
_kill:     file format elf32-i386


Disassembly of section .text:

00001000 <main>:
    1000:	55                   	push   %ebp
    1001:	89 e5                	mov    %esp,%ebp
    1003:	83 e4 f0             	and    $0xfffffff0,%esp
    1006:	83 ec 20             	sub    $0x20,%esp
    1009:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    100d:	7f 19                	jg     1028 <main+0x28>
    100f:	c7 44 24 04 a1 1a 00 	movl   $0x1aa1,0x4(%esp)
    1016:	00 
    1017:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
    101e:	e8 46 04 00 00       	call   1469 <printf>
    1023:	e8 a0 02 00 00       	call   12c8 <exit>
    1028:	c7 44 24 1c 01 00 00 	movl   $0x1,0x1c(%esp)
    102f:	00 
    1030:	eb 21                	jmp    1053 <main+0x53>
    1032:	8b 44 24 1c          	mov    0x1c(%esp),%eax
    1036:	c1 e0 02             	shl    $0x2,%eax
    1039:	03 45 0c             	add    0xc(%ebp),%eax
    103c:	8b 00                	mov    (%eax),%eax
    103e:	89 04 24             	mov    %eax,(%esp)
    1041:	e8 f0 01 00 00       	call   1236 <atoi>
    1046:	89 04 24             	mov    %eax,(%esp)
    1049:	e8 aa 02 00 00       	call   12f8 <kill>
    104e:	83 44 24 1c 01       	addl   $0x1,0x1c(%esp)
    1053:	8b 44 24 1c          	mov    0x1c(%esp),%eax
    1057:	3b 45 08             	cmp    0x8(%ebp),%eax
    105a:	7c d6                	jl     1032 <main+0x32>
    105c:	e8 67 02 00 00       	call   12c8 <exit>
    1061:	90                   	nop
    1062:	90                   	nop
    1063:	90                   	nop

00001064 <stosb>:
    1064:	55                   	push   %ebp
    1065:	89 e5                	mov    %esp,%ebp
    1067:	57                   	push   %edi
    1068:	53                   	push   %ebx
    1069:	8b 4d 08             	mov    0x8(%ebp),%ecx
    106c:	8b 55 10             	mov    0x10(%ebp),%edx
    106f:	8b 45 0c             	mov    0xc(%ebp),%eax
    1072:	89 cb                	mov    %ecx,%ebx
    1074:	89 df                	mov    %ebx,%edi
    1076:	89 d1                	mov    %edx,%ecx
    1078:	fc                   	cld    
    1079:	f3 aa                	rep stos %al,%es:(%edi)
    107b:	89 ca                	mov    %ecx,%edx
    107d:	89 fb                	mov    %edi,%ebx
    107f:	89 5d 08             	mov    %ebx,0x8(%ebp)
    1082:	89 55 10             	mov    %edx,0x10(%ebp)
    1085:	5b                   	pop    %ebx
    1086:	5f                   	pop    %edi
    1087:	5d                   	pop    %ebp
    1088:	c3                   	ret    

00001089 <strcpy>:
    1089:	55                   	push   %ebp
    108a:	89 e5                	mov    %esp,%ebp
    108c:	83 ec 10             	sub    $0x10,%esp
    108f:	8b 45 08             	mov    0x8(%ebp),%eax
    1092:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1095:	8b 45 0c             	mov    0xc(%ebp),%eax
    1098:	0f b6 10             	movzbl (%eax),%edx
    109b:	8b 45 08             	mov    0x8(%ebp),%eax
    109e:	88 10                	mov    %dl,(%eax)
    10a0:	8b 45 08             	mov    0x8(%ebp),%eax
    10a3:	0f b6 00             	movzbl (%eax),%eax
    10a6:	84 c0                	test   %al,%al
    10a8:	0f 95 c0             	setne  %al
    10ab:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    10af:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
    10b3:	84 c0                	test   %al,%al
    10b5:	75 de                	jne    1095 <strcpy+0xc>
    10b7:	8b 45 fc             	mov    -0x4(%ebp),%eax
    10ba:	c9                   	leave  
    10bb:	c3                   	ret    

000010bc <strcmp>:
    10bc:	55                   	push   %ebp
    10bd:	89 e5                	mov    %esp,%ebp
    10bf:	eb 08                	jmp    10c9 <strcmp+0xd>
    10c1:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    10c5:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
    10c9:	8b 45 08             	mov    0x8(%ebp),%eax
    10cc:	0f b6 00             	movzbl (%eax),%eax
    10cf:	84 c0                	test   %al,%al
    10d1:	74 10                	je     10e3 <strcmp+0x27>
    10d3:	8b 45 08             	mov    0x8(%ebp),%eax
    10d6:	0f b6 10             	movzbl (%eax),%edx
    10d9:	8b 45 0c             	mov    0xc(%ebp),%eax
    10dc:	0f b6 00             	movzbl (%eax),%eax
    10df:	38 c2                	cmp    %al,%dl
    10e1:	74 de                	je     10c1 <strcmp+0x5>
    10e3:	8b 45 08             	mov    0x8(%ebp),%eax
    10e6:	0f b6 00             	movzbl (%eax),%eax
    10e9:	0f b6 d0             	movzbl %al,%edx
    10ec:	8b 45 0c             	mov    0xc(%ebp),%eax
    10ef:	0f b6 00             	movzbl (%eax),%eax
    10f2:	0f b6 c0             	movzbl %al,%eax
    10f5:	89 d1                	mov    %edx,%ecx
    10f7:	29 c1                	sub    %eax,%ecx
    10f9:	89 c8                	mov    %ecx,%eax
    10fb:	5d                   	pop    %ebp
    10fc:	c3                   	ret    

000010fd <strlen>:
    10fd:	55                   	push   %ebp
    10fe:	89 e5                	mov    %esp,%ebp
    1100:	83 ec 10             	sub    $0x10,%esp
    1103:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    110a:	eb 04                	jmp    1110 <strlen+0x13>
    110c:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    1110:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1113:	03 45 08             	add    0x8(%ebp),%eax
    1116:	0f b6 00             	movzbl (%eax),%eax
    1119:	84 c0                	test   %al,%al
    111b:	75 ef                	jne    110c <strlen+0xf>
    111d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1120:	c9                   	leave  
    1121:	c3                   	ret    

00001122 <memset>:
    1122:	55                   	push   %ebp
    1123:	89 e5                	mov    %esp,%ebp
    1125:	83 ec 0c             	sub    $0xc,%esp
    1128:	8b 45 10             	mov    0x10(%ebp),%eax
    112b:	89 44 24 08          	mov    %eax,0x8(%esp)
    112f:	8b 45 0c             	mov    0xc(%ebp),%eax
    1132:	89 44 24 04          	mov    %eax,0x4(%esp)
    1136:	8b 45 08             	mov    0x8(%ebp),%eax
    1139:	89 04 24             	mov    %eax,(%esp)
    113c:	e8 23 ff ff ff       	call   1064 <stosb>
    1141:	8b 45 08             	mov    0x8(%ebp),%eax
    1144:	c9                   	leave  
    1145:	c3                   	ret    

00001146 <strchr>:
    1146:	55                   	push   %ebp
    1147:	89 e5                	mov    %esp,%ebp
    1149:	83 ec 04             	sub    $0x4,%esp
    114c:	8b 45 0c             	mov    0xc(%ebp),%eax
    114f:	88 45 fc             	mov    %al,-0x4(%ebp)
    1152:	eb 14                	jmp    1168 <strchr+0x22>
    1154:	8b 45 08             	mov    0x8(%ebp),%eax
    1157:	0f b6 00             	movzbl (%eax),%eax
    115a:	3a 45 fc             	cmp    -0x4(%ebp),%al
    115d:	75 05                	jne    1164 <strchr+0x1e>
    115f:	8b 45 08             	mov    0x8(%ebp),%eax
    1162:	eb 13                	jmp    1177 <strchr+0x31>
    1164:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1168:	8b 45 08             	mov    0x8(%ebp),%eax
    116b:	0f b6 00             	movzbl (%eax),%eax
    116e:	84 c0                	test   %al,%al
    1170:	75 e2                	jne    1154 <strchr+0xe>
    1172:	b8 00 00 00 00       	mov    $0x0,%eax
    1177:	c9                   	leave  
    1178:	c3                   	ret    

00001179 <gets>:
    1179:	55                   	push   %ebp
    117a:	89 e5                	mov    %esp,%ebp
    117c:	83 ec 28             	sub    $0x28,%esp
    117f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1186:	eb 44                	jmp    11cc <gets+0x53>
    1188:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    118f:	00 
    1190:	8d 45 ef             	lea    -0x11(%ebp),%eax
    1193:	89 44 24 04          	mov    %eax,0x4(%esp)
    1197:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    119e:	e8 3d 01 00 00       	call   12e0 <read>
    11a3:	89 45 f4             	mov    %eax,-0xc(%ebp)
    11a6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    11aa:	7e 2d                	jle    11d9 <gets+0x60>
    11ac:	8b 45 f0             	mov    -0x10(%ebp),%eax
    11af:	03 45 08             	add    0x8(%ebp),%eax
    11b2:	0f b6 55 ef          	movzbl -0x11(%ebp),%edx
    11b6:	88 10                	mov    %dl,(%eax)
    11b8:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    11bc:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    11c0:	3c 0a                	cmp    $0xa,%al
    11c2:	74 16                	je     11da <gets+0x61>
    11c4:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    11c8:	3c 0d                	cmp    $0xd,%al
    11ca:	74 0e                	je     11da <gets+0x61>
    11cc:	8b 45 f0             	mov    -0x10(%ebp),%eax
    11cf:	83 c0 01             	add    $0x1,%eax
    11d2:	3b 45 0c             	cmp    0xc(%ebp),%eax
    11d5:	7c b1                	jl     1188 <gets+0xf>
    11d7:	eb 01                	jmp    11da <gets+0x61>
    11d9:	90                   	nop
    11da:	8b 45 f0             	mov    -0x10(%ebp),%eax
    11dd:	03 45 08             	add    0x8(%ebp),%eax
    11e0:	c6 00 00             	movb   $0x0,(%eax)
    11e3:	8b 45 08             	mov    0x8(%ebp),%eax
    11e6:	c9                   	leave  
    11e7:	c3                   	ret    

000011e8 <stat>:
    11e8:	55                   	push   %ebp
    11e9:	89 e5                	mov    %esp,%ebp
    11eb:	83 ec 28             	sub    $0x28,%esp
    11ee:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    11f5:	00 
    11f6:	8b 45 08             	mov    0x8(%ebp),%eax
    11f9:	89 04 24             	mov    %eax,(%esp)
    11fc:	e8 07 01 00 00       	call   1308 <open>
    1201:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1204:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1208:	79 07                	jns    1211 <stat+0x29>
    120a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    120f:	eb 23                	jmp    1234 <stat+0x4c>
    1211:	8b 45 0c             	mov    0xc(%ebp),%eax
    1214:	89 44 24 04          	mov    %eax,0x4(%esp)
    1218:	8b 45 f0             	mov    -0x10(%ebp),%eax
    121b:	89 04 24             	mov    %eax,(%esp)
    121e:	e8 fd 00 00 00       	call   1320 <fstat>
    1223:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1226:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1229:	89 04 24             	mov    %eax,(%esp)
    122c:	e8 bf 00 00 00       	call   12f0 <close>
    1231:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1234:	c9                   	leave  
    1235:	c3                   	ret    

00001236 <atoi>:
    1236:	55                   	push   %ebp
    1237:	89 e5                	mov    %esp,%ebp
    1239:	83 ec 10             	sub    $0x10,%esp
    123c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    1243:	eb 24                	jmp    1269 <atoi+0x33>
    1245:	8b 55 fc             	mov    -0x4(%ebp),%edx
    1248:	89 d0                	mov    %edx,%eax
    124a:	c1 e0 02             	shl    $0x2,%eax
    124d:	01 d0                	add    %edx,%eax
    124f:	01 c0                	add    %eax,%eax
    1251:	89 c2                	mov    %eax,%edx
    1253:	8b 45 08             	mov    0x8(%ebp),%eax
    1256:	0f b6 00             	movzbl (%eax),%eax
    1259:	0f be c0             	movsbl %al,%eax
    125c:	8d 04 02             	lea    (%edx,%eax,1),%eax
    125f:	83 e8 30             	sub    $0x30,%eax
    1262:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1265:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1269:	8b 45 08             	mov    0x8(%ebp),%eax
    126c:	0f b6 00             	movzbl (%eax),%eax
    126f:	3c 2f                	cmp    $0x2f,%al
    1271:	7e 0a                	jle    127d <atoi+0x47>
    1273:	8b 45 08             	mov    0x8(%ebp),%eax
    1276:	0f b6 00             	movzbl (%eax),%eax
    1279:	3c 39                	cmp    $0x39,%al
    127b:	7e c8                	jle    1245 <atoi+0xf>
    127d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1280:	c9                   	leave  
    1281:	c3                   	ret    

00001282 <memmove>:
    1282:	55                   	push   %ebp
    1283:	89 e5                	mov    %esp,%ebp
    1285:	83 ec 10             	sub    $0x10,%esp
    1288:	8b 45 08             	mov    0x8(%ebp),%eax
    128b:	89 45 f8             	mov    %eax,-0x8(%ebp)
    128e:	8b 45 0c             	mov    0xc(%ebp),%eax
    1291:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1294:	eb 13                	jmp    12a9 <memmove+0x27>
    1296:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1299:	0f b6 10             	movzbl (%eax),%edx
    129c:	8b 45 f8             	mov    -0x8(%ebp),%eax
    129f:	88 10                	mov    %dl,(%eax)
    12a1:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    12a5:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    12a9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    12ad:	0f 9f c0             	setg   %al
    12b0:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
    12b4:	84 c0                	test   %al,%al
    12b6:	75 de                	jne    1296 <memmove+0x14>
    12b8:	8b 45 08             	mov    0x8(%ebp),%eax
    12bb:	c9                   	leave  
    12bc:	c3                   	ret    
    12bd:	90                   	nop
    12be:	90                   	nop
    12bf:	90                   	nop

000012c0 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    12c0:	b8 01 00 00 00       	mov    $0x1,%eax
    12c5:	cd 40                	int    $0x40
    12c7:	c3                   	ret    

000012c8 <exit>:
SYSCALL(exit)
    12c8:	b8 02 00 00 00       	mov    $0x2,%eax
    12cd:	cd 40                	int    $0x40
    12cf:	c3                   	ret    

000012d0 <wait>:
SYSCALL(wait)
    12d0:	b8 03 00 00 00       	mov    $0x3,%eax
    12d5:	cd 40                	int    $0x40
    12d7:	c3                   	ret    

000012d8 <pipe>:
SYSCALL(pipe)
    12d8:	b8 04 00 00 00       	mov    $0x4,%eax
    12dd:	cd 40                	int    $0x40
    12df:	c3                   	ret    

000012e0 <read>:
SYSCALL(read)
    12e0:	b8 05 00 00 00       	mov    $0x5,%eax
    12e5:	cd 40                	int    $0x40
    12e7:	c3                   	ret    

000012e8 <write>:
SYSCALL(write)
    12e8:	b8 10 00 00 00       	mov    $0x10,%eax
    12ed:	cd 40                	int    $0x40
    12ef:	c3                   	ret    

000012f0 <close>:
SYSCALL(close)
    12f0:	b8 15 00 00 00       	mov    $0x15,%eax
    12f5:	cd 40                	int    $0x40
    12f7:	c3                   	ret    

000012f8 <kill>:
SYSCALL(kill)
    12f8:	b8 06 00 00 00       	mov    $0x6,%eax
    12fd:	cd 40                	int    $0x40
    12ff:	c3                   	ret    

00001300 <exec>:
SYSCALL(exec)
    1300:	b8 07 00 00 00       	mov    $0x7,%eax
    1305:	cd 40                	int    $0x40
    1307:	c3                   	ret    

00001308 <open>:
SYSCALL(open)
    1308:	b8 0f 00 00 00       	mov    $0xf,%eax
    130d:	cd 40                	int    $0x40
    130f:	c3                   	ret    

00001310 <mknod>:
SYSCALL(mknod)
    1310:	b8 11 00 00 00       	mov    $0x11,%eax
    1315:	cd 40                	int    $0x40
    1317:	c3                   	ret    

00001318 <unlink>:
SYSCALL(unlink)
    1318:	b8 12 00 00 00       	mov    $0x12,%eax
    131d:	cd 40                	int    $0x40
    131f:	c3                   	ret    

00001320 <fstat>:
SYSCALL(fstat)
    1320:	b8 08 00 00 00       	mov    $0x8,%eax
    1325:	cd 40                	int    $0x40
    1327:	c3                   	ret    

00001328 <link>:
SYSCALL(link)
    1328:	b8 13 00 00 00       	mov    $0x13,%eax
    132d:	cd 40                	int    $0x40
    132f:	c3                   	ret    

00001330 <mkdir>:
SYSCALL(mkdir)
    1330:	b8 14 00 00 00       	mov    $0x14,%eax
    1335:	cd 40                	int    $0x40
    1337:	c3                   	ret    

00001338 <chdir>:
SYSCALL(chdir)
    1338:	b8 09 00 00 00       	mov    $0x9,%eax
    133d:	cd 40                	int    $0x40
    133f:	c3                   	ret    

00001340 <dup>:
SYSCALL(dup)
    1340:	b8 0a 00 00 00       	mov    $0xa,%eax
    1345:	cd 40                	int    $0x40
    1347:	c3                   	ret    

00001348 <getpid>:
SYSCALL(getpid)
    1348:	b8 0b 00 00 00       	mov    $0xb,%eax
    134d:	cd 40                	int    $0x40
    134f:	c3                   	ret    

00001350 <sbrk>:
SYSCALL(sbrk)
    1350:	b8 0c 00 00 00       	mov    $0xc,%eax
    1355:	cd 40                	int    $0x40
    1357:	c3                   	ret    

00001358 <sleep>:
SYSCALL(sleep)
    1358:	b8 0d 00 00 00       	mov    $0xd,%eax
    135d:	cd 40                	int    $0x40
    135f:	c3                   	ret    

00001360 <uptime>:
SYSCALL(uptime)
    1360:	b8 0e 00 00 00       	mov    $0xe,%eax
    1365:	cd 40                	int    $0x40
    1367:	c3                   	ret    

00001368 <clone>:
SYSCALL(clone)
    1368:	b8 16 00 00 00       	mov    $0x16,%eax
    136d:	cd 40                	int    $0x40
    136f:	c3                   	ret    

00001370 <texit>:
SYSCALL(texit)
    1370:	b8 17 00 00 00       	mov    $0x17,%eax
    1375:	cd 40                	int    $0x40
    1377:	c3                   	ret    

00001378 <tsleep>:
SYSCALL(tsleep)
    1378:	b8 18 00 00 00       	mov    $0x18,%eax
    137d:	cd 40                	int    $0x40
    137f:	c3                   	ret    

00001380 <twakeup>:
SYSCALL(twakeup)
    1380:	b8 19 00 00 00       	mov    $0x19,%eax
    1385:	cd 40                	int    $0x40
    1387:	c3                   	ret    

00001388 <thread_yield>:
SYSCALL(thread_yield)
    1388:	b8 1a 00 00 00       	mov    $0x1a,%eax
    138d:	cd 40                	int    $0x40
    138f:	c3                   	ret    

00001390 <putc>:
    1390:	55                   	push   %ebp
    1391:	89 e5                	mov    %esp,%ebp
    1393:	83 ec 28             	sub    $0x28,%esp
    1396:	8b 45 0c             	mov    0xc(%ebp),%eax
    1399:	88 45 f4             	mov    %al,-0xc(%ebp)
    139c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    13a3:	00 
    13a4:	8d 45 f4             	lea    -0xc(%ebp),%eax
    13a7:	89 44 24 04          	mov    %eax,0x4(%esp)
    13ab:	8b 45 08             	mov    0x8(%ebp),%eax
    13ae:	89 04 24             	mov    %eax,(%esp)
    13b1:	e8 32 ff ff ff       	call   12e8 <write>
    13b6:	c9                   	leave  
    13b7:	c3                   	ret    

000013b8 <printint>:
    13b8:	55                   	push   %ebp
    13b9:	89 e5                	mov    %esp,%ebp
    13bb:	53                   	push   %ebx
    13bc:	83 ec 44             	sub    $0x44,%esp
    13bf:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    13c6:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    13ca:	74 17                	je     13e3 <printint+0x2b>
    13cc:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    13d0:	79 11                	jns    13e3 <printint+0x2b>
    13d2:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    13d9:	8b 45 0c             	mov    0xc(%ebp),%eax
    13dc:	f7 d8                	neg    %eax
    13de:	89 45 f4             	mov    %eax,-0xc(%ebp)
    13e1:	eb 06                	jmp    13e9 <printint+0x31>
    13e3:	8b 45 0c             	mov    0xc(%ebp),%eax
    13e6:	89 45 f4             	mov    %eax,-0xc(%ebp)
    13e9:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    13f0:	8b 4d ec             	mov    -0x14(%ebp),%ecx
    13f3:	8b 5d 10             	mov    0x10(%ebp),%ebx
    13f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13f9:	ba 00 00 00 00       	mov    $0x0,%edx
    13fe:	f7 f3                	div    %ebx
    1400:	89 d0                	mov    %edx,%eax
    1402:	0f b6 80 e8 1a 00 00 	movzbl 0x1ae8(%eax),%eax
    1409:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
    140d:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1411:	8b 45 10             	mov    0x10(%ebp),%eax
    1414:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    1417:	8b 45 f4             	mov    -0xc(%ebp),%eax
    141a:	ba 00 00 00 00       	mov    $0x0,%edx
    141f:	f7 75 d4             	divl   -0x2c(%ebp)
    1422:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1425:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1429:	75 c5                	jne    13f0 <printint+0x38>
    142b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    142f:	74 28                	je     1459 <printint+0xa1>
    1431:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1434:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)
    1439:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    143d:	eb 1a                	jmp    1459 <printint+0xa1>
    143f:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1442:	0f b6 44 05 dc       	movzbl -0x24(%ebp,%eax,1),%eax
    1447:	0f be c0             	movsbl %al,%eax
    144a:	89 44 24 04          	mov    %eax,0x4(%esp)
    144e:	8b 45 08             	mov    0x8(%ebp),%eax
    1451:	89 04 24             	mov    %eax,(%esp)
    1454:	e8 37 ff ff ff       	call   1390 <putc>
    1459:	83 6d ec 01          	subl   $0x1,-0x14(%ebp)
    145d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1461:	79 dc                	jns    143f <printint+0x87>
    1463:	83 c4 44             	add    $0x44,%esp
    1466:	5b                   	pop    %ebx
    1467:	5d                   	pop    %ebp
    1468:	c3                   	ret    

00001469 <printf>:
    1469:	55                   	push   %ebp
    146a:	89 e5                	mov    %esp,%ebp
    146c:	83 ec 38             	sub    $0x38,%esp
    146f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1476:	8d 45 0c             	lea    0xc(%ebp),%eax
    1479:	83 c0 04             	add    $0x4,%eax
    147c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    147f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    1486:	e9 7e 01 00 00       	jmp    1609 <printf+0x1a0>
    148b:	8b 55 0c             	mov    0xc(%ebp),%edx
    148e:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1491:	8d 04 02             	lea    (%edx,%eax,1),%eax
    1494:	0f b6 00             	movzbl (%eax),%eax
    1497:	0f be c0             	movsbl %al,%eax
    149a:	25 ff 00 00 00       	and    $0xff,%eax
    149f:	89 45 e8             	mov    %eax,-0x18(%ebp)
    14a2:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    14a6:	75 2c                	jne    14d4 <printf+0x6b>
    14a8:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    14ac:	75 0c                	jne    14ba <printf+0x51>
    14ae:	c7 45 f0 25 00 00 00 	movl   $0x25,-0x10(%ebp)
    14b5:	e9 4b 01 00 00       	jmp    1605 <printf+0x19c>
    14ba:	8b 45 e8             	mov    -0x18(%ebp),%eax
    14bd:	0f be c0             	movsbl %al,%eax
    14c0:	89 44 24 04          	mov    %eax,0x4(%esp)
    14c4:	8b 45 08             	mov    0x8(%ebp),%eax
    14c7:	89 04 24             	mov    %eax,(%esp)
    14ca:	e8 c1 fe ff ff       	call   1390 <putc>
    14cf:	e9 31 01 00 00       	jmp    1605 <printf+0x19c>
    14d4:	83 7d f0 25          	cmpl   $0x25,-0x10(%ebp)
    14d8:	0f 85 27 01 00 00    	jne    1605 <printf+0x19c>
    14de:	83 7d e8 64          	cmpl   $0x64,-0x18(%ebp)
    14e2:	75 2d                	jne    1511 <printf+0xa8>
    14e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14e7:	8b 00                	mov    (%eax),%eax
    14e9:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
    14f0:	00 
    14f1:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    14f8:	00 
    14f9:	89 44 24 04          	mov    %eax,0x4(%esp)
    14fd:	8b 45 08             	mov    0x8(%ebp),%eax
    1500:	89 04 24             	mov    %eax,(%esp)
    1503:	e8 b0 fe ff ff       	call   13b8 <printint>
    1508:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    150c:	e9 ed 00 00 00       	jmp    15fe <printf+0x195>
    1511:	83 7d e8 78          	cmpl   $0x78,-0x18(%ebp)
    1515:	74 06                	je     151d <printf+0xb4>
    1517:	83 7d e8 70          	cmpl   $0x70,-0x18(%ebp)
    151b:	75 2d                	jne    154a <printf+0xe1>
    151d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1520:	8b 00                	mov    (%eax),%eax
    1522:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    1529:	00 
    152a:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    1531:	00 
    1532:	89 44 24 04          	mov    %eax,0x4(%esp)
    1536:	8b 45 08             	mov    0x8(%ebp),%eax
    1539:	89 04 24             	mov    %eax,(%esp)
    153c:	e8 77 fe ff ff       	call   13b8 <printint>
    1541:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    1545:	e9 b4 00 00 00       	jmp    15fe <printf+0x195>
    154a:	83 7d e8 73          	cmpl   $0x73,-0x18(%ebp)
    154e:	75 46                	jne    1596 <printf+0x12d>
    1550:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1553:	8b 00                	mov    (%eax),%eax
    1555:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    1558:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    155c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    1560:	75 27                	jne    1589 <printf+0x120>
    1562:	c7 45 e4 b5 1a 00 00 	movl   $0x1ab5,-0x1c(%ebp)
    1569:	eb 1f                	jmp    158a <printf+0x121>
    156b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    156e:	0f b6 00             	movzbl (%eax),%eax
    1571:	0f be c0             	movsbl %al,%eax
    1574:	89 44 24 04          	mov    %eax,0x4(%esp)
    1578:	8b 45 08             	mov    0x8(%ebp),%eax
    157b:	89 04 24             	mov    %eax,(%esp)
    157e:	e8 0d fe ff ff       	call   1390 <putc>
    1583:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    1587:	eb 01                	jmp    158a <printf+0x121>
    1589:	90                   	nop
    158a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    158d:	0f b6 00             	movzbl (%eax),%eax
    1590:	84 c0                	test   %al,%al
    1592:	75 d7                	jne    156b <printf+0x102>
    1594:	eb 68                	jmp    15fe <printf+0x195>
    1596:	83 7d e8 63          	cmpl   $0x63,-0x18(%ebp)
    159a:	75 1d                	jne    15b9 <printf+0x150>
    159c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    159f:	8b 00                	mov    (%eax),%eax
    15a1:	0f be c0             	movsbl %al,%eax
    15a4:	89 44 24 04          	mov    %eax,0x4(%esp)
    15a8:	8b 45 08             	mov    0x8(%ebp),%eax
    15ab:	89 04 24             	mov    %eax,(%esp)
    15ae:	e8 dd fd ff ff       	call   1390 <putc>
    15b3:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    15b7:	eb 45                	jmp    15fe <printf+0x195>
    15b9:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    15bd:	75 17                	jne    15d6 <printf+0x16d>
    15bf:	8b 45 e8             	mov    -0x18(%ebp),%eax
    15c2:	0f be c0             	movsbl %al,%eax
    15c5:	89 44 24 04          	mov    %eax,0x4(%esp)
    15c9:	8b 45 08             	mov    0x8(%ebp),%eax
    15cc:	89 04 24             	mov    %eax,(%esp)
    15cf:	e8 bc fd ff ff       	call   1390 <putc>
    15d4:	eb 28                	jmp    15fe <printf+0x195>
    15d6:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
    15dd:	00 
    15de:	8b 45 08             	mov    0x8(%ebp),%eax
    15e1:	89 04 24             	mov    %eax,(%esp)
    15e4:	e8 a7 fd ff ff       	call   1390 <putc>
    15e9:	8b 45 e8             	mov    -0x18(%ebp),%eax
    15ec:	0f be c0             	movsbl %al,%eax
    15ef:	89 44 24 04          	mov    %eax,0x4(%esp)
    15f3:	8b 45 08             	mov    0x8(%ebp),%eax
    15f6:	89 04 24             	mov    %eax,(%esp)
    15f9:	e8 92 fd ff ff       	call   1390 <putc>
    15fe:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1605:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1609:	8b 55 0c             	mov    0xc(%ebp),%edx
    160c:	8b 45 ec             	mov    -0x14(%ebp),%eax
    160f:	8d 04 02             	lea    (%edx,%eax,1),%eax
    1612:	0f b6 00             	movzbl (%eax),%eax
    1615:	84 c0                	test   %al,%al
    1617:	0f 85 6e fe ff ff    	jne    148b <printf+0x22>
    161d:	c9                   	leave  
    161e:	c3                   	ret    
    161f:	90                   	nop

00001620 <free>:
    1620:	55                   	push   %ebp
    1621:	89 e5                	mov    %esp,%ebp
    1623:	83 ec 10             	sub    $0x10,%esp
    1626:	8b 45 08             	mov    0x8(%ebp),%eax
    1629:	83 e8 08             	sub    $0x8,%eax
    162c:	89 45 f8             	mov    %eax,-0x8(%ebp)
    162f:	a1 08 1b 00 00       	mov    0x1b08,%eax
    1634:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1637:	eb 24                	jmp    165d <free+0x3d>
    1639:	8b 45 fc             	mov    -0x4(%ebp),%eax
    163c:	8b 00                	mov    (%eax),%eax
    163e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1641:	77 12                	ja     1655 <free+0x35>
    1643:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1646:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1649:	77 24                	ja     166f <free+0x4f>
    164b:	8b 45 fc             	mov    -0x4(%ebp),%eax
    164e:	8b 00                	mov    (%eax),%eax
    1650:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1653:	77 1a                	ja     166f <free+0x4f>
    1655:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1658:	8b 00                	mov    (%eax),%eax
    165a:	89 45 fc             	mov    %eax,-0x4(%ebp)
    165d:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1660:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1663:	76 d4                	jbe    1639 <free+0x19>
    1665:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1668:	8b 00                	mov    (%eax),%eax
    166a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    166d:	76 ca                	jbe    1639 <free+0x19>
    166f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1672:	8b 40 04             	mov    0x4(%eax),%eax
    1675:	c1 e0 03             	shl    $0x3,%eax
    1678:	89 c2                	mov    %eax,%edx
    167a:	03 55 f8             	add    -0x8(%ebp),%edx
    167d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1680:	8b 00                	mov    (%eax),%eax
    1682:	39 c2                	cmp    %eax,%edx
    1684:	75 24                	jne    16aa <free+0x8a>
    1686:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1689:	8b 50 04             	mov    0x4(%eax),%edx
    168c:	8b 45 fc             	mov    -0x4(%ebp),%eax
    168f:	8b 00                	mov    (%eax),%eax
    1691:	8b 40 04             	mov    0x4(%eax),%eax
    1694:	01 c2                	add    %eax,%edx
    1696:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1699:	89 50 04             	mov    %edx,0x4(%eax)
    169c:	8b 45 fc             	mov    -0x4(%ebp),%eax
    169f:	8b 00                	mov    (%eax),%eax
    16a1:	8b 10                	mov    (%eax),%edx
    16a3:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16a6:	89 10                	mov    %edx,(%eax)
    16a8:	eb 0a                	jmp    16b4 <free+0x94>
    16aa:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16ad:	8b 10                	mov    (%eax),%edx
    16af:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16b2:	89 10                	mov    %edx,(%eax)
    16b4:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16b7:	8b 40 04             	mov    0x4(%eax),%eax
    16ba:	c1 e0 03             	shl    $0x3,%eax
    16bd:	03 45 fc             	add    -0x4(%ebp),%eax
    16c0:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    16c3:	75 20                	jne    16e5 <free+0xc5>
    16c5:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16c8:	8b 50 04             	mov    0x4(%eax),%edx
    16cb:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16ce:	8b 40 04             	mov    0x4(%eax),%eax
    16d1:	01 c2                	add    %eax,%edx
    16d3:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16d6:	89 50 04             	mov    %edx,0x4(%eax)
    16d9:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16dc:	8b 10                	mov    (%eax),%edx
    16de:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16e1:	89 10                	mov    %edx,(%eax)
    16e3:	eb 08                	jmp    16ed <free+0xcd>
    16e5:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16e8:	8b 55 f8             	mov    -0x8(%ebp),%edx
    16eb:	89 10                	mov    %edx,(%eax)
    16ed:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16f0:	a3 08 1b 00 00       	mov    %eax,0x1b08
    16f5:	c9                   	leave  
    16f6:	c3                   	ret    

000016f7 <morecore>:
    16f7:	55                   	push   %ebp
    16f8:	89 e5                	mov    %esp,%ebp
    16fa:	83 ec 28             	sub    $0x28,%esp
    16fd:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    1704:	77 07                	ja     170d <morecore+0x16>
    1706:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
    170d:	8b 45 08             	mov    0x8(%ebp),%eax
    1710:	c1 e0 03             	shl    $0x3,%eax
    1713:	89 04 24             	mov    %eax,(%esp)
    1716:	e8 35 fc ff ff       	call   1350 <sbrk>
    171b:	89 45 f0             	mov    %eax,-0x10(%ebp)
    171e:	83 7d f0 ff          	cmpl   $0xffffffff,-0x10(%ebp)
    1722:	75 07                	jne    172b <morecore+0x34>
    1724:	b8 00 00 00 00       	mov    $0x0,%eax
    1729:	eb 22                	jmp    174d <morecore+0x56>
    172b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    172e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1731:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1734:	8b 55 08             	mov    0x8(%ebp),%edx
    1737:	89 50 04             	mov    %edx,0x4(%eax)
    173a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    173d:	83 c0 08             	add    $0x8,%eax
    1740:	89 04 24             	mov    %eax,(%esp)
    1743:	e8 d8 fe ff ff       	call   1620 <free>
    1748:	a1 08 1b 00 00       	mov    0x1b08,%eax
    174d:	c9                   	leave  
    174e:	c3                   	ret    

0000174f <malloc>:
    174f:	55                   	push   %ebp
    1750:	89 e5                	mov    %esp,%ebp
    1752:	83 ec 28             	sub    $0x28,%esp
    1755:	8b 45 08             	mov    0x8(%ebp),%eax
    1758:	83 c0 07             	add    $0x7,%eax
    175b:	c1 e8 03             	shr    $0x3,%eax
    175e:	83 c0 01             	add    $0x1,%eax
    1761:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1764:	a1 08 1b 00 00       	mov    0x1b08,%eax
    1769:	89 45 f0             	mov    %eax,-0x10(%ebp)
    176c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1770:	75 23                	jne    1795 <malloc+0x46>
    1772:	c7 45 f0 00 1b 00 00 	movl   $0x1b00,-0x10(%ebp)
    1779:	8b 45 f0             	mov    -0x10(%ebp),%eax
    177c:	a3 08 1b 00 00       	mov    %eax,0x1b08
    1781:	a1 08 1b 00 00       	mov    0x1b08,%eax
    1786:	a3 00 1b 00 00       	mov    %eax,0x1b00
    178b:	c7 05 04 1b 00 00 00 	movl   $0x0,0x1b04
    1792:	00 00 00 
    1795:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1798:	8b 00                	mov    (%eax),%eax
    179a:	89 45 ec             	mov    %eax,-0x14(%ebp)
    179d:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17a0:	8b 40 04             	mov    0x4(%eax),%eax
    17a3:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    17a6:	72 4d                	jb     17f5 <malloc+0xa6>
    17a8:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17ab:	8b 40 04             	mov    0x4(%eax),%eax
    17ae:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    17b1:	75 0c                	jne    17bf <malloc+0x70>
    17b3:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17b6:	8b 10                	mov    (%eax),%edx
    17b8:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17bb:	89 10                	mov    %edx,(%eax)
    17bd:	eb 26                	jmp    17e5 <malloc+0x96>
    17bf:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17c2:	8b 40 04             	mov    0x4(%eax),%eax
    17c5:	89 c2                	mov    %eax,%edx
    17c7:	2b 55 f4             	sub    -0xc(%ebp),%edx
    17ca:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17cd:	89 50 04             	mov    %edx,0x4(%eax)
    17d0:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17d3:	8b 40 04             	mov    0x4(%eax),%eax
    17d6:	c1 e0 03             	shl    $0x3,%eax
    17d9:	01 45 ec             	add    %eax,-0x14(%ebp)
    17dc:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17df:	8b 55 f4             	mov    -0xc(%ebp),%edx
    17e2:	89 50 04             	mov    %edx,0x4(%eax)
    17e5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17e8:	a3 08 1b 00 00       	mov    %eax,0x1b08
    17ed:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17f0:	83 c0 08             	add    $0x8,%eax
    17f3:	eb 38                	jmp    182d <malloc+0xde>
    17f5:	a1 08 1b 00 00       	mov    0x1b08,%eax
    17fa:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    17fd:	75 1b                	jne    181a <malloc+0xcb>
    17ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1802:	89 04 24             	mov    %eax,(%esp)
    1805:	e8 ed fe ff ff       	call   16f7 <morecore>
    180a:	89 45 ec             	mov    %eax,-0x14(%ebp)
    180d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1811:	75 07                	jne    181a <malloc+0xcb>
    1813:	b8 00 00 00 00       	mov    $0x0,%eax
    1818:	eb 13                	jmp    182d <malloc+0xde>
    181a:	8b 45 ec             	mov    -0x14(%ebp),%eax
    181d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1820:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1823:	8b 00                	mov    (%eax),%eax
    1825:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1828:	e9 70 ff ff ff       	jmp    179d <malloc+0x4e>
    182d:	c9                   	leave  
    182e:	c3                   	ret    
    182f:	90                   	nop

00001830 <xchg>:
    1830:	55                   	push   %ebp
    1831:	89 e5                	mov    %esp,%ebp
    1833:	83 ec 10             	sub    $0x10,%esp
    1836:	8b 55 08             	mov    0x8(%ebp),%edx
    1839:	8b 45 0c             	mov    0xc(%ebp),%eax
    183c:	8b 4d 08             	mov    0x8(%ebp),%ecx
    183f:	f0 87 02             	lock xchg %eax,(%edx)
    1842:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1845:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1848:	c9                   	leave  
    1849:	c3                   	ret    

0000184a <lock_init>:
    184a:	55                   	push   %ebp
    184b:	89 e5                	mov    %esp,%ebp
    184d:	8b 45 08             	mov    0x8(%ebp),%eax
    1850:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    1856:	5d                   	pop    %ebp
    1857:	c3                   	ret    

00001858 <lock_acquire>:
    1858:	55                   	push   %ebp
    1859:	89 e5                	mov    %esp,%ebp
    185b:	83 ec 08             	sub    $0x8,%esp
    185e:	8b 45 08             	mov    0x8(%ebp),%eax
    1861:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    1868:	00 
    1869:	89 04 24             	mov    %eax,(%esp)
    186c:	e8 bf ff ff ff       	call   1830 <xchg>
    1871:	85 c0                	test   %eax,%eax
    1873:	75 e9                	jne    185e <lock_acquire+0x6>
    1875:	c9                   	leave  
    1876:	c3                   	ret    

00001877 <lock_release>:
    1877:	55                   	push   %ebp
    1878:	89 e5                	mov    %esp,%ebp
    187a:	83 ec 08             	sub    $0x8,%esp
    187d:	8b 45 08             	mov    0x8(%ebp),%eax
    1880:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1887:	00 
    1888:	89 04 24             	mov    %eax,(%esp)
    188b:	e8 a0 ff ff ff       	call   1830 <xchg>
    1890:	c9                   	leave  
    1891:	c3                   	ret    

00001892 <thread_create>:
    1892:	55                   	push   %ebp
    1893:	89 e5                	mov    %esp,%ebp
    1895:	83 ec 28             	sub    $0x28,%esp
    1898:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
    189f:	e8 ab fe ff ff       	call   174f <malloc>
    18a4:	89 45 f0             	mov    %eax,-0x10(%ebp)
    18a7:	8b 45 f0             	mov    -0x10(%ebp),%eax
    18aa:	89 45 f4             	mov    %eax,-0xc(%ebp)
    18ad:	8b 45 f0             	mov    -0x10(%ebp),%eax
    18b0:	25 ff 0f 00 00       	and    $0xfff,%eax
    18b5:	85 c0                	test   %eax,%eax
    18b7:	74 15                	je     18ce <thread_create+0x3c>
    18b9:	8b 45 f0             	mov    -0x10(%ebp),%eax
    18bc:	89 c2                	mov    %eax,%edx
    18be:	81 e2 ff 0f 00 00    	and    $0xfff,%edx
    18c4:	b8 00 10 00 00       	mov    $0x1000,%eax
    18c9:	29 d0                	sub    %edx,%eax
    18cb:	01 45 f0             	add    %eax,-0x10(%ebp)
    18ce:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    18d2:	75 1b                	jne    18ef <thread_create+0x5d>
    18d4:	c7 44 24 04 bc 1a 00 	movl   $0x1abc,0x4(%esp)
    18db:	00 
    18dc:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    18e3:	e8 81 fb ff ff       	call   1469 <printf>
    18e8:	b8 00 00 00 00       	mov    $0x0,%eax
    18ed:	eb 6f                	jmp    195e <thread_create+0xcc>
    18ef:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    18f2:	8b 55 08             	mov    0x8(%ebp),%edx
    18f5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    18f8:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
    18fc:	89 54 24 08          	mov    %edx,0x8(%esp)
    1900:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
    1907:	00 
    1908:	89 04 24             	mov    %eax,(%esp)
    190b:	e8 58 fa ff ff       	call   1368 <clone>
    1910:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1913:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1917:	79 1b                	jns    1934 <thread_create+0xa2>
    1919:	c7 44 24 04 ca 1a 00 	movl   $0x1aca,0x4(%esp)
    1920:	00 
    1921:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1928:	e8 3c fb ff ff       	call   1469 <printf>
    192d:	b8 00 00 00 00       	mov    $0x0,%eax
    1932:	eb 2a                	jmp    195e <thread_create+0xcc>
    1934:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1938:	7e 05                	jle    193f <thread_create+0xad>
    193a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    193d:	eb 1f                	jmp    195e <thread_create+0xcc>
    193f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1943:	75 14                	jne    1959 <thread_create+0xc7>
    1945:	c7 44 24 04 d7 1a 00 	movl   $0x1ad7,0x4(%esp)
    194c:	00 
    194d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1954:	e8 10 fb ff ff       	call   1469 <printf>
    1959:	b8 00 00 00 00       	mov    $0x0,%eax
    195e:	c9                   	leave  
    195f:	c3                   	ret    

00001960 <random>:
    1960:	55                   	push   %ebp
    1961:	89 e5                	mov    %esp,%ebp
    1963:	a1 fc 1a 00 00       	mov    0x1afc,%eax
    1968:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
    196e:	05 69 f3 6e 3c       	add    $0x3c6ef369,%eax
    1973:	a3 fc 1a 00 00       	mov    %eax,0x1afc
    1978:	a1 fc 1a 00 00       	mov    0x1afc,%eax
    197d:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1980:	ba 00 00 00 00       	mov    $0x0,%edx
    1985:	f7 f1                	div    %ecx
    1987:	89 d0                	mov    %edx,%eax
    1989:	5d                   	pop    %ebp
    198a:	c3                   	ret    
    198b:	90                   	nop

0000198c <init_q>:
    198c:	55                   	push   %ebp
    198d:	89 e5                	mov    %esp,%ebp
    198f:	8b 45 08             	mov    0x8(%ebp),%eax
    1992:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    1998:	8b 45 08             	mov    0x8(%ebp),%eax
    199b:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    19a2:	8b 45 08             	mov    0x8(%ebp),%eax
    19a5:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
    19ac:	5d                   	pop    %ebp
    19ad:	c3                   	ret    

000019ae <add_q>:
    19ae:	55                   	push   %ebp
    19af:	89 e5                	mov    %esp,%ebp
    19b1:	83 ec 28             	sub    $0x28,%esp
    19b4:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
    19bb:	e8 8f fd ff ff       	call   174f <malloc>
    19c0:	89 45 f4             	mov    %eax,-0xc(%ebp)
    19c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19c6:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    19cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19d0:	8b 55 0c             	mov    0xc(%ebp),%edx
    19d3:	89 10                	mov    %edx,(%eax)
    19d5:	8b 45 08             	mov    0x8(%ebp),%eax
    19d8:	8b 40 04             	mov    0x4(%eax),%eax
    19db:	85 c0                	test   %eax,%eax
    19dd:	75 0b                	jne    19ea <add_q+0x3c>
    19df:	8b 45 08             	mov    0x8(%ebp),%eax
    19e2:	8b 55 f4             	mov    -0xc(%ebp),%edx
    19e5:	89 50 04             	mov    %edx,0x4(%eax)
    19e8:	eb 0c                	jmp    19f6 <add_q+0x48>
    19ea:	8b 45 08             	mov    0x8(%ebp),%eax
    19ed:	8b 40 08             	mov    0x8(%eax),%eax
    19f0:	8b 55 f4             	mov    -0xc(%ebp),%edx
    19f3:	89 50 04             	mov    %edx,0x4(%eax)
    19f6:	8b 45 08             	mov    0x8(%ebp),%eax
    19f9:	8b 55 f4             	mov    -0xc(%ebp),%edx
    19fc:	89 50 08             	mov    %edx,0x8(%eax)
    19ff:	8b 45 08             	mov    0x8(%ebp),%eax
    1a02:	8b 00                	mov    (%eax),%eax
    1a04:	8d 50 01             	lea    0x1(%eax),%edx
    1a07:	8b 45 08             	mov    0x8(%ebp),%eax
    1a0a:	89 10                	mov    %edx,(%eax)
    1a0c:	c9                   	leave  
    1a0d:	c3                   	ret    

00001a0e <empty_q>:
    1a0e:	55                   	push   %ebp
    1a0f:	89 e5                	mov    %esp,%ebp
    1a11:	8b 45 08             	mov    0x8(%ebp),%eax
    1a14:	8b 00                	mov    (%eax),%eax
    1a16:	85 c0                	test   %eax,%eax
    1a18:	75 07                	jne    1a21 <empty_q+0x13>
    1a1a:	b8 01 00 00 00       	mov    $0x1,%eax
    1a1f:	eb 05                	jmp    1a26 <empty_q+0x18>
    1a21:	b8 00 00 00 00       	mov    $0x0,%eax
    1a26:	5d                   	pop    %ebp
    1a27:	c3                   	ret    

00001a28 <pop_q>:
    1a28:	55                   	push   %ebp
    1a29:	89 e5                	mov    %esp,%ebp
    1a2b:	83 ec 28             	sub    $0x28,%esp
    1a2e:	8b 45 08             	mov    0x8(%ebp),%eax
    1a31:	89 04 24             	mov    %eax,(%esp)
    1a34:	e8 d5 ff ff ff       	call   1a0e <empty_q>
    1a39:	85 c0                	test   %eax,%eax
    1a3b:	75 5d                	jne    1a9a <pop_q+0x72>
    1a3d:	8b 45 08             	mov    0x8(%ebp),%eax
    1a40:	8b 40 04             	mov    0x4(%eax),%eax
    1a43:	8b 00                	mov    (%eax),%eax
    1a45:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1a48:	8b 45 08             	mov    0x8(%ebp),%eax
    1a4b:	8b 40 04             	mov    0x4(%eax),%eax
    1a4e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1a51:	8b 45 08             	mov    0x8(%ebp),%eax
    1a54:	8b 40 04             	mov    0x4(%eax),%eax
    1a57:	8b 50 04             	mov    0x4(%eax),%edx
    1a5a:	8b 45 08             	mov    0x8(%ebp),%eax
    1a5d:	89 50 04             	mov    %edx,0x4(%eax)
    1a60:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a63:	89 04 24             	mov    %eax,(%esp)
    1a66:	e8 b5 fb ff ff       	call   1620 <free>
    1a6b:	8b 45 08             	mov    0x8(%ebp),%eax
    1a6e:	8b 00                	mov    (%eax),%eax
    1a70:	8d 50 ff             	lea    -0x1(%eax),%edx
    1a73:	8b 45 08             	mov    0x8(%ebp),%eax
    1a76:	89 10                	mov    %edx,(%eax)
    1a78:	8b 45 08             	mov    0x8(%ebp),%eax
    1a7b:	8b 00                	mov    (%eax),%eax
    1a7d:	85 c0                	test   %eax,%eax
    1a7f:	75 14                	jne    1a95 <pop_q+0x6d>
    1a81:	8b 45 08             	mov    0x8(%ebp),%eax
    1a84:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    1a8b:	8b 45 08             	mov    0x8(%ebp),%eax
    1a8e:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
    1a95:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1a98:	eb 05                	jmp    1a9f <pop_q+0x77>
    1a9a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1a9f:	c9                   	leave  
    1aa0:	c3                   	ret    
