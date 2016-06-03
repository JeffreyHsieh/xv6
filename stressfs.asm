
_stressfs:     file format elf32-i386


Disassembly of section .text:

00001000 <main>:
    1000:	55                   	push   %ebp
    1001:	89 e5                	mov    %esp,%ebp
    1003:	83 e4 f0             	and    $0xfffffff0,%esp
    1006:	81 ec 30 02 00 00    	sub    $0x230,%esp
    100c:	c7 84 24 1e 02 00 00 	movl   $0x65727473,0x21e(%esp)
    1013:	73 74 72 65 
    1017:	c7 84 24 22 02 00 00 	movl   $0x73667373,0x222(%esp)
    101e:	73 73 66 73 
    1022:	66 c7 84 24 26 02 00 	movw   $0x30,0x226(%esp)
    1029:	00 30 00 
    102c:	c7 44 24 04 f5 1b 00 	movl   $0x1bf5,0x4(%esp)
    1033:	00 
    1034:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    103b:	e8 7d 05 00 00       	call   15bd <printf>
    1040:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
    1047:	00 
    1048:	c7 44 24 04 61 00 00 	movl   $0x61,0x4(%esp)
    104f:	00 
    1050:	8d 44 24 1e          	lea    0x1e(%esp),%eax
    1054:	89 04 24             	mov    %eax,(%esp)
    1057:	e8 1a 02 00 00       	call   1276 <memset>
    105c:	c7 84 24 2c 02 00 00 	movl   $0x0,0x22c(%esp)
    1063:	00 00 00 00 
    1067:	eb 11                	jmp    107a <main+0x7a>
    1069:	e8 a6 03 00 00       	call   1414 <fork>
    106e:	85 c0                	test   %eax,%eax
    1070:	7f 14                	jg     1086 <main+0x86>
    1072:	83 84 24 2c 02 00 00 	addl   $0x1,0x22c(%esp)
    1079:	01 
    107a:	83 bc 24 2c 02 00 00 	cmpl   $0x3,0x22c(%esp)
    1081:	03 
    1082:	7e e5                	jle    1069 <main+0x69>
    1084:	eb 01                	jmp    1087 <main+0x87>
    1086:	90                   	nop
    1087:	8b 84 24 2c 02 00 00 	mov    0x22c(%esp),%eax
    108e:	89 44 24 08          	mov    %eax,0x8(%esp)
    1092:	c7 44 24 04 08 1c 00 	movl   $0x1c08,0x4(%esp)
    1099:	00 
    109a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    10a1:	e8 17 05 00 00       	call   15bd <printf>
    10a6:	0f b6 84 24 26 02 00 	movzbl 0x226(%esp),%eax
    10ad:	00 
    10ae:	89 c2                	mov    %eax,%edx
    10b0:	8b 84 24 2c 02 00 00 	mov    0x22c(%esp),%eax
    10b7:	8d 04 02             	lea    (%edx,%eax,1),%eax
    10ba:	88 84 24 26 02 00 00 	mov    %al,0x226(%esp)
    10c1:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    10c8:	00 
    10c9:	8d 84 24 1e 02 00 00 	lea    0x21e(%esp),%eax
    10d0:	89 04 24             	mov    %eax,(%esp)
    10d3:	e8 84 03 00 00       	call   145c <open>
    10d8:	89 84 24 28 02 00 00 	mov    %eax,0x228(%esp)
    10df:	c7 84 24 2c 02 00 00 	movl   $0x0,0x22c(%esp)
    10e6:	00 00 00 00 
    10ea:	eb 27                	jmp    1113 <main+0x113>
    10ec:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
    10f3:	00 
    10f4:	8d 44 24 1e          	lea    0x1e(%esp),%eax
    10f8:	89 44 24 04          	mov    %eax,0x4(%esp)
    10fc:	8b 84 24 28 02 00 00 	mov    0x228(%esp),%eax
    1103:	89 04 24             	mov    %eax,(%esp)
    1106:	e8 31 03 00 00       	call   143c <write>
    110b:	83 84 24 2c 02 00 00 	addl   $0x1,0x22c(%esp)
    1112:	01 
    1113:	83 bc 24 2c 02 00 00 	cmpl   $0x13,0x22c(%esp)
    111a:	13 
    111b:	7e cf                	jle    10ec <main+0xec>
    111d:	8b 84 24 28 02 00 00 	mov    0x228(%esp),%eax
    1124:	89 04 24             	mov    %eax,(%esp)
    1127:	e8 18 03 00 00       	call   1444 <close>
    112c:	c7 44 24 04 12 1c 00 	movl   $0x1c12,0x4(%esp)
    1133:	00 
    1134:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    113b:	e8 7d 04 00 00       	call   15bd <printf>
    1140:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1147:	00 
    1148:	8d 84 24 1e 02 00 00 	lea    0x21e(%esp),%eax
    114f:	89 04 24             	mov    %eax,(%esp)
    1152:	e8 05 03 00 00       	call   145c <open>
    1157:	89 84 24 28 02 00 00 	mov    %eax,0x228(%esp)
    115e:	c7 84 24 2c 02 00 00 	movl   $0x0,0x22c(%esp)
    1165:	00 00 00 00 
    1169:	eb 27                	jmp    1192 <main+0x192>
    116b:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
    1172:	00 
    1173:	8d 44 24 1e          	lea    0x1e(%esp),%eax
    1177:	89 44 24 04          	mov    %eax,0x4(%esp)
    117b:	8b 84 24 28 02 00 00 	mov    0x228(%esp),%eax
    1182:	89 04 24             	mov    %eax,(%esp)
    1185:	e8 aa 02 00 00       	call   1434 <read>
    118a:	83 84 24 2c 02 00 00 	addl   $0x1,0x22c(%esp)
    1191:	01 
    1192:	83 bc 24 2c 02 00 00 	cmpl   $0x13,0x22c(%esp)
    1199:	13 
    119a:	7e cf                	jle    116b <main+0x16b>
    119c:	8b 84 24 28 02 00 00 	mov    0x228(%esp),%eax
    11a3:	89 04 24             	mov    %eax,(%esp)
    11a6:	e8 99 02 00 00       	call   1444 <close>
    11ab:	e8 74 02 00 00       	call   1424 <wait>
    11b0:	e8 67 02 00 00       	call   141c <exit>
    11b5:	90                   	nop
    11b6:	90                   	nop
    11b7:	90                   	nop

000011b8 <stosb>:
    11b8:	55                   	push   %ebp
    11b9:	89 e5                	mov    %esp,%ebp
    11bb:	57                   	push   %edi
    11bc:	53                   	push   %ebx
    11bd:	8b 4d 08             	mov    0x8(%ebp),%ecx
    11c0:	8b 55 10             	mov    0x10(%ebp),%edx
    11c3:	8b 45 0c             	mov    0xc(%ebp),%eax
    11c6:	89 cb                	mov    %ecx,%ebx
    11c8:	89 df                	mov    %ebx,%edi
    11ca:	89 d1                	mov    %edx,%ecx
    11cc:	fc                   	cld    
    11cd:	f3 aa                	rep stos %al,%es:(%edi)
    11cf:	89 ca                	mov    %ecx,%edx
    11d1:	89 fb                	mov    %edi,%ebx
    11d3:	89 5d 08             	mov    %ebx,0x8(%ebp)
    11d6:	89 55 10             	mov    %edx,0x10(%ebp)
    11d9:	5b                   	pop    %ebx
    11da:	5f                   	pop    %edi
    11db:	5d                   	pop    %ebp
    11dc:	c3                   	ret    

000011dd <strcpy>:
    11dd:	55                   	push   %ebp
    11de:	89 e5                	mov    %esp,%ebp
    11e0:	83 ec 10             	sub    $0x10,%esp
    11e3:	8b 45 08             	mov    0x8(%ebp),%eax
    11e6:	89 45 fc             	mov    %eax,-0x4(%ebp)
    11e9:	8b 45 0c             	mov    0xc(%ebp),%eax
    11ec:	0f b6 10             	movzbl (%eax),%edx
    11ef:	8b 45 08             	mov    0x8(%ebp),%eax
    11f2:	88 10                	mov    %dl,(%eax)
    11f4:	8b 45 08             	mov    0x8(%ebp),%eax
    11f7:	0f b6 00             	movzbl (%eax),%eax
    11fa:	84 c0                	test   %al,%al
    11fc:	0f 95 c0             	setne  %al
    11ff:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1203:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
    1207:	84 c0                	test   %al,%al
    1209:	75 de                	jne    11e9 <strcpy+0xc>
    120b:	8b 45 fc             	mov    -0x4(%ebp),%eax
    120e:	c9                   	leave  
    120f:	c3                   	ret    

00001210 <strcmp>:
    1210:	55                   	push   %ebp
    1211:	89 e5                	mov    %esp,%ebp
    1213:	eb 08                	jmp    121d <strcmp+0xd>
    1215:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1219:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
    121d:	8b 45 08             	mov    0x8(%ebp),%eax
    1220:	0f b6 00             	movzbl (%eax),%eax
    1223:	84 c0                	test   %al,%al
    1225:	74 10                	je     1237 <strcmp+0x27>
    1227:	8b 45 08             	mov    0x8(%ebp),%eax
    122a:	0f b6 10             	movzbl (%eax),%edx
    122d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1230:	0f b6 00             	movzbl (%eax),%eax
    1233:	38 c2                	cmp    %al,%dl
    1235:	74 de                	je     1215 <strcmp+0x5>
    1237:	8b 45 08             	mov    0x8(%ebp),%eax
    123a:	0f b6 00             	movzbl (%eax),%eax
    123d:	0f b6 d0             	movzbl %al,%edx
    1240:	8b 45 0c             	mov    0xc(%ebp),%eax
    1243:	0f b6 00             	movzbl (%eax),%eax
    1246:	0f b6 c0             	movzbl %al,%eax
    1249:	89 d1                	mov    %edx,%ecx
    124b:	29 c1                	sub    %eax,%ecx
    124d:	89 c8                	mov    %ecx,%eax
    124f:	5d                   	pop    %ebp
    1250:	c3                   	ret    

00001251 <strlen>:
    1251:	55                   	push   %ebp
    1252:	89 e5                	mov    %esp,%ebp
    1254:	83 ec 10             	sub    $0x10,%esp
    1257:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    125e:	eb 04                	jmp    1264 <strlen+0x13>
    1260:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    1264:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1267:	03 45 08             	add    0x8(%ebp),%eax
    126a:	0f b6 00             	movzbl (%eax),%eax
    126d:	84 c0                	test   %al,%al
    126f:	75 ef                	jne    1260 <strlen+0xf>
    1271:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1274:	c9                   	leave  
    1275:	c3                   	ret    

00001276 <memset>:
    1276:	55                   	push   %ebp
    1277:	89 e5                	mov    %esp,%ebp
    1279:	83 ec 0c             	sub    $0xc,%esp
    127c:	8b 45 10             	mov    0x10(%ebp),%eax
    127f:	89 44 24 08          	mov    %eax,0x8(%esp)
    1283:	8b 45 0c             	mov    0xc(%ebp),%eax
    1286:	89 44 24 04          	mov    %eax,0x4(%esp)
    128a:	8b 45 08             	mov    0x8(%ebp),%eax
    128d:	89 04 24             	mov    %eax,(%esp)
    1290:	e8 23 ff ff ff       	call   11b8 <stosb>
    1295:	8b 45 08             	mov    0x8(%ebp),%eax
    1298:	c9                   	leave  
    1299:	c3                   	ret    

0000129a <strchr>:
    129a:	55                   	push   %ebp
    129b:	89 e5                	mov    %esp,%ebp
    129d:	83 ec 04             	sub    $0x4,%esp
    12a0:	8b 45 0c             	mov    0xc(%ebp),%eax
    12a3:	88 45 fc             	mov    %al,-0x4(%ebp)
    12a6:	eb 14                	jmp    12bc <strchr+0x22>
    12a8:	8b 45 08             	mov    0x8(%ebp),%eax
    12ab:	0f b6 00             	movzbl (%eax),%eax
    12ae:	3a 45 fc             	cmp    -0x4(%ebp),%al
    12b1:	75 05                	jne    12b8 <strchr+0x1e>
    12b3:	8b 45 08             	mov    0x8(%ebp),%eax
    12b6:	eb 13                	jmp    12cb <strchr+0x31>
    12b8:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    12bc:	8b 45 08             	mov    0x8(%ebp),%eax
    12bf:	0f b6 00             	movzbl (%eax),%eax
    12c2:	84 c0                	test   %al,%al
    12c4:	75 e2                	jne    12a8 <strchr+0xe>
    12c6:	b8 00 00 00 00       	mov    $0x0,%eax
    12cb:	c9                   	leave  
    12cc:	c3                   	ret    

000012cd <gets>:
    12cd:	55                   	push   %ebp
    12ce:	89 e5                	mov    %esp,%ebp
    12d0:	83 ec 28             	sub    $0x28,%esp
    12d3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    12da:	eb 44                	jmp    1320 <gets+0x53>
    12dc:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    12e3:	00 
    12e4:	8d 45 ef             	lea    -0x11(%ebp),%eax
    12e7:	89 44 24 04          	mov    %eax,0x4(%esp)
    12eb:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    12f2:	e8 3d 01 00 00       	call   1434 <read>
    12f7:	89 45 f4             	mov    %eax,-0xc(%ebp)
    12fa:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    12fe:	7e 2d                	jle    132d <gets+0x60>
    1300:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1303:	03 45 08             	add    0x8(%ebp),%eax
    1306:	0f b6 55 ef          	movzbl -0x11(%ebp),%edx
    130a:	88 10                	mov    %dl,(%eax)
    130c:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1310:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    1314:	3c 0a                	cmp    $0xa,%al
    1316:	74 16                	je     132e <gets+0x61>
    1318:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    131c:	3c 0d                	cmp    $0xd,%al
    131e:	74 0e                	je     132e <gets+0x61>
    1320:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1323:	83 c0 01             	add    $0x1,%eax
    1326:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1329:	7c b1                	jl     12dc <gets+0xf>
    132b:	eb 01                	jmp    132e <gets+0x61>
    132d:	90                   	nop
    132e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1331:	03 45 08             	add    0x8(%ebp),%eax
    1334:	c6 00 00             	movb   $0x0,(%eax)
    1337:	8b 45 08             	mov    0x8(%ebp),%eax
    133a:	c9                   	leave  
    133b:	c3                   	ret    

0000133c <stat>:
    133c:	55                   	push   %ebp
    133d:	89 e5                	mov    %esp,%ebp
    133f:	83 ec 28             	sub    $0x28,%esp
    1342:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1349:	00 
    134a:	8b 45 08             	mov    0x8(%ebp),%eax
    134d:	89 04 24             	mov    %eax,(%esp)
    1350:	e8 07 01 00 00       	call   145c <open>
    1355:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1358:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    135c:	79 07                	jns    1365 <stat+0x29>
    135e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1363:	eb 23                	jmp    1388 <stat+0x4c>
    1365:	8b 45 0c             	mov    0xc(%ebp),%eax
    1368:	89 44 24 04          	mov    %eax,0x4(%esp)
    136c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    136f:	89 04 24             	mov    %eax,(%esp)
    1372:	e8 fd 00 00 00       	call   1474 <fstat>
    1377:	89 45 f4             	mov    %eax,-0xc(%ebp)
    137a:	8b 45 f0             	mov    -0x10(%ebp),%eax
    137d:	89 04 24             	mov    %eax,(%esp)
    1380:	e8 bf 00 00 00       	call   1444 <close>
    1385:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1388:	c9                   	leave  
    1389:	c3                   	ret    

0000138a <atoi>:
    138a:	55                   	push   %ebp
    138b:	89 e5                	mov    %esp,%ebp
    138d:	83 ec 10             	sub    $0x10,%esp
    1390:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    1397:	eb 24                	jmp    13bd <atoi+0x33>
    1399:	8b 55 fc             	mov    -0x4(%ebp),%edx
    139c:	89 d0                	mov    %edx,%eax
    139e:	c1 e0 02             	shl    $0x2,%eax
    13a1:	01 d0                	add    %edx,%eax
    13a3:	01 c0                	add    %eax,%eax
    13a5:	89 c2                	mov    %eax,%edx
    13a7:	8b 45 08             	mov    0x8(%ebp),%eax
    13aa:	0f b6 00             	movzbl (%eax),%eax
    13ad:	0f be c0             	movsbl %al,%eax
    13b0:	8d 04 02             	lea    (%edx,%eax,1),%eax
    13b3:	83 e8 30             	sub    $0x30,%eax
    13b6:	89 45 fc             	mov    %eax,-0x4(%ebp)
    13b9:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    13bd:	8b 45 08             	mov    0x8(%ebp),%eax
    13c0:	0f b6 00             	movzbl (%eax),%eax
    13c3:	3c 2f                	cmp    $0x2f,%al
    13c5:	7e 0a                	jle    13d1 <atoi+0x47>
    13c7:	8b 45 08             	mov    0x8(%ebp),%eax
    13ca:	0f b6 00             	movzbl (%eax),%eax
    13cd:	3c 39                	cmp    $0x39,%al
    13cf:	7e c8                	jle    1399 <atoi+0xf>
    13d1:	8b 45 fc             	mov    -0x4(%ebp),%eax
    13d4:	c9                   	leave  
    13d5:	c3                   	ret    

000013d6 <memmove>:
    13d6:	55                   	push   %ebp
    13d7:	89 e5                	mov    %esp,%ebp
    13d9:	83 ec 10             	sub    $0x10,%esp
    13dc:	8b 45 08             	mov    0x8(%ebp),%eax
    13df:	89 45 f8             	mov    %eax,-0x8(%ebp)
    13e2:	8b 45 0c             	mov    0xc(%ebp),%eax
    13e5:	89 45 fc             	mov    %eax,-0x4(%ebp)
    13e8:	eb 13                	jmp    13fd <memmove+0x27>
    13ea:	8b 45 fc             	mov    -0x4(%ebp),%eax
    13ed:	0f b6 10             	movzbl (%eax),%edx
    13f0:	8b 45 f8             	mov    -0x8(%ebp),%eax
    13f3:	88 10                	mov    %dl,(%eax)
    13f5:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    13f9:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    13fd:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1401:	0f 9f c0             	setg   %al
    1404:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
    1408:	84 c0                	test   %al,%al
    140a:	75 de                	jne    13ea <memmove+0x14>
    140c:	8b 45 08             	mov    0x8(%ebp),%eax
    140f:	c9                   	leave  
    1410:	c3                   	ret    
    1411:	90                   	nop
    1412:	90                   	nop
    1413:	90                   	nop

00001414 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    1414:	b8 01 00 00 00       	mov    $0x1,%eax
    1419:	cd 40                	int    $0x40
    141b:	c3                   	ret    

0000141c <exit>:
SYSCALL(exit)
    141c:	b8 02 00 00 00       	mov    $0x2,%eax
    1421:	cd 40                	int    $0x40
    1423:	c3                   	ret    

00001424 <wait>:
SYSCALL(wait)
    1424:	b8 03 00 00 00       	mov    $0x3,%eax
    1429:	cd 40                	int    $0x40
    142b:	c3                   	ret    

0000142c <pipe>:
SYSCALL(pipe)
    142c:	b8 04 00 00 00       	mov    $0x4,%eax
    1431:	cd 40                	int    $0x40
    1433:	c3                   	ret    

00001434 <read>:
SYSCALL(read)
    1434:	b8 05 00 00 00       	mov    $0x5,%eax
    1439:	cd 40                	int    $0x40
    143b:	c3                   	ret    

0000143c <write>:
SYSCALL(write)
    143c:	b8 10 00 00 00       	mov    $0x10,%eax
    1441:	cd 40                	int    $0x40
    1443:	c3                   	ret    

00001444 <close>:
SYSCALL(close)
    1444:	b8 15 00 00 00       	mov    $0x15,%eax
    1449:	cd 40                	int    $0x40
    144b:	c3                   	ret    

0000144c <kill>:
SYSCALL(kill)
    144c:	b8 06 00 00 00       	mov    $0x6,%eax
    1451:	cd 40                	int    $0x40
    1453:	c3                   	ret    

00001454 <exec>:
SYSCALL(exec)
    1454:	b8 07 00 00 00       	mov    $0x7,%eax
    1459:	cd 40                	int    $0x40
    145b:	c3                   	ret    

0000145c <open>:
SYSCALL(open)
    145c:	b8 0f 00 00 00       	mov    $0xf,%eax
    1461:	cd 40                	int    $0x40
    1463:	c3                   	ret    

00001464 <mknod>:
SYSCALL(mknod)
    1464:	b8 11 00 00 00       	mov    $0x11,%eax
    1469:	cd 40                	int    $0x40
    146b:	c3                   	ret    

0000146c <unlink>:
SYSCALL(unlink)
    146c:	b8 12 00 00 00       	mov    $0x12,%eax
    1471:	cd 40                	int    $0x40
    1473:	c3                   	ret    

00001474 <fstat>:
SYSCALL(fstat)
    1474:	b8 08 00 00 00       	mov    $0x8,%eax
    1479:	cd 40                	int    $0x40
    147b:	c3                   	ret    

0000147c <link>:
SYSCALL(link)
    147c:	b8 13 00 00 00       	mov    $0x13,%eax
    1481:	cd 40                	int    $0x40
    1483:	c3                   	ret    

00001484 <mkdir>:
SYSCALL(mkdir)
    1484:	b8 14 00 00 00       	mov    $0x14,%eax
    1489:	cd 40                	int    $0x40
    148b:	c3                   	ret    

0000148c <chdir>:
SYSCALL(chdir)
    148c:	b8 09 00 00 00       	mov    $0x9,%eax
    1491:	cd 40                	int    $0x40
    1493:	c3                   	ret    

00001494 <dup>:
SYSCALL(dup)
    1494:	b8 0a 00 00 00       	mov    $0xa,%eax
    1499:	cd 40                	int    $0x40
    149b:	c3                   	ret    

0000149c <getpid>:
SYSCALL(getpid)
    149c:	b8 0b 00 00 00       	mov    $0xb,%eax
    14a1:	cd 40                	int    $0x40
    14a3:	c3                   	ret    

000014a4 <sbrk>:
SYSCALL(sbrk)
    14a4:	b8 0c 00 00 00       	mov    $0xc,%eax
    14a9:	cd 40                	int    $0x40
    14ab:	c3                   	ret    

000014ac <sleep>:
SYSCALL(sleep)
    14ac:	b8 0d 00 00 00       	mov    $0xd,%eax
    14b1:	cd 40                	int    $0x40
    14b3:	c3                   	ret    

000014b4 <uptime>:
SYSCALL(uptime)
    14b4:	b8 0e 00 00 00       	mov    $0xe,%eax
    14b9:	cd 40                	int    $0x40
    14bb:	c3                   	ret    

000014bc <clone>:
SYSCALL(clone)
    14bc:	b8 16 00 00 00       	mov    $0x16,%eax
    14c1:	cd 40                	int    $0x40
    14c3:	c3                   	ret    

000014c4 <texit>:
SYSCALL(texit)
    14c4:	b8 17 00 00 00       	mov    $0x17,%eax
    14c9:	cd 40                	int    $0x40
    14cb:	c3                   	ret    

000014cc <tsleep>:
SYSCALL(tsleep)
    14cc:	b8 18 00 00 00       	mov    $0x18,%eax
    14d1:	cd 40                	int    $0x40
    14d3:	c3                   	ret    

000014d4 <twakeup>:
SYSCALL(twakeup)
    14d4:	b8 19 00 00 00       	mov    $0x19,%eax
    14d9:	cd 40                	int    $0x40
    14db:	c3                   	ret    

000014dc <thread_yield>:
SYSCALL(thread_yield)
    14dc:	b8 1a 00 00 00       	mov    $0x1a,%eax
    14e1:	cd 40                	int    $0x40
    14e3:	c3                   	ret    

000014e4 <putc>:
    14e4:	55                   	push   %ebp
    14e5:	89 e5                	mov    %esp,%ebp
    14e7:	83 ec 28             	sub    $0x28,%esp
    14ea:	8b 45 0c             	mov    0xc(%ebp),%eax
    14ed:	88 45 f4             	mov    %al,-0xc(%ebp)
    14f0:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    14f7:	00 
    14f8:	8d 45 f4             	lea    -0xc(%ebp),%eax
    14fb:	89 44 24 04          	mov    %eax,0x4(%esp)
    14ff:	8b 45 08             	mov    0x8(%ebp),%eax
    1502:	89 04 24             	mov    %eax,(%esp)
    1505:	e8 32 ff ff ff       	call   143c <write>
    150a:	c9                   	leave  
    150b:	c3                   	ret    

0000150c <printint>:
    150c:	55                   	push   %ebp
    150d:	89 e5                	mov    %esp,%ebp
    150f:	53                   	push   %ebx
    1510:	83 ec 44             	sub    $0x44,%esp
    1513:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    151a:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    151e:	74 17                	je     1537 <printint+0x2b>
    1520:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1524:	79 11                	jns    1537 <printint+0x2b>
    1526:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    152d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1530:	f7 d8                	neg    %eax
    1532:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1535:	eb 06                	jmp    153d <printint+0x31>
    1537:	8b 45 0c             	mov    0xc(%ebp),%eax
    153a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    153d:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    1544:	8b 4d ec             	mov    -0x14(%ebp),%ecx
    1547:	8b 5d 10             	mov    0x10(%ebp),%ebx
    154a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    154d:	ba 00 00 00 00       	mov    $0x0,%edx
    1552:	f7 f3                	div    %ebx
    1554:	89 d0                	mov    %edx,%eax
    1556:	0f b6 80 4c 1c 00 00 	movzbl 0x1c4c(%eax),%eax
    155d:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
    1561:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1565:	8b 45 10             	mov    0x10(%ebp),%eax
    1568:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    156b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    156e:	ba 00 00 00 00       	mov    $0x0,%edx
    1573:	f7 75 d4             	divl   -0x2c(%ebp)
    1576:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1579:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    157d:	75 c5                	jne    1544 <printint+0x38>
    157f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1583:	74 28                	je     15ad <printint+0xa1>
    1585:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1588:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)
    158d:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1591:	eb 1a                	jmp    15ad <printint+0xa1>
    1593:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1596:	0f b6 44 05 dc       	movzbl -0x24(%ebp,%eax,1),%eax
    159b:	0f be c0             	movsbl %al,%eax
    159e:	89 44 24 04          	mov    %eax,0x4(%esp)
    15a2:	8b 45 08             	mov    0x8(%ebp),%eax
    15a5:	89 04 24             	mov    %eax,(%esp)
    15a8:	e8 37 ff ff ff       	call   14e4 <putc>
    15ad:	83 6d ec 01          	subl   $0x1,-0x14(%ebp)
    15b1:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    15b5:	79 dc                	jns    1593 <printint+0x87>
    15b7:	83 c4 44             	add    $0x44,%esp
    15ba:	5b                   	pop    %ebx
    15bb:	5d                   	pop    %ebp
    15bc:	c3                   	ret    

000015bd <printf>:
    15bd:	55                   	push   %ebp
    15be:	89 e5                	mov    %esp,%ebp
    15c0:	83 ec 38             	sub    $0x38,%esp
    15c3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    15ca:	8d 45 0c             	lea    0xc(%ebp),%eax
    15cd:	83 c0 04             	add    $0x4,%eax
    15d0:	89 45 f4             	mov    %eax,-0xc(%ebp)
    15d3:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    15da:	e9 7e 01 00 00       	jmp    175d <printf+0x1a0>
    15df:	8b 55 0c             	mov    0xc(%ebp),%edx
    15e2:	8b 45 ec             	mov    -0x14(%ebp),%eax
    15e5:	8d 04 02             	lea    (%edx,%eax,1),%eax
    15e8:	0f b6 00             	movzbl (%eax),%eax
    15eb:	0f be c0             	movsbl %al,%eax
    15ee:	25 ff 00 00 00       	and    $0xff,%eax
    15f3:	89 45 e8             	mov    %eax,-0x18(%ebp)
    15f6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    15fa:	75 2c                	jne    1628 <printf+0x6b>
    15fc:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    1600:	75 0c                	jne    160e <printf+0x51>
    1602:	c7 45 f0 25 00 00 00 	movl   $0x25,-0x10(%ebp)
    1609:	e9 4b 01 00 00       	jmp    1759 <printf+0x19c>
    160e:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1611:	0f be c0             	movsbl %al,%eax
    1614:	89 44 24 04          	mov    %eax,0x4(%esp)
    1618:	8b 45 08             	mov    0x8(%ebp),%eax
    161b:	89 04 24             	mov    %eax,(%esp)
    161e:	e8 c1 fe ff ff       	call   14e4 <putc>
    1623:	e9 31 01 00 00       	jmp    1759 <printf+0x19c>
    1628:	83 7d f0 25          	cmpl   $0x25,-0x10(%ebp)
    162c:	0f 85 27 01 00 00    	jne    1759 <printf+0x19c>
    1632:	83 7d e8 64          	cmpl   $0x64,-0x18(%ebp)
    1636:	75 2d                	jne    1665 <printf+0xa8>
    1638:	8b 45 f4             	mov    -0xc(%ebp),%eax
    163b:	8b 00                	mov    (%eax),%eax
    163d:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
    1644:	00 
    1645:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    164c:	00 
    164d:	89 44 24 04          	mov    %eax,0x4(%esp)
    1651:	8b 45 08             	mov    0x8(%ebp),%eax
    1654:	89 04 24             	mov    %eax,(%esp)
    1657:	e8 b0 fe ff ff       	call   150c <printint>
    165c:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    1660:	e9 ed 00 00 00       	jmp    1752 <printf+0x195>
    1665:	83 7d e8 78          	cmpl   $0x78,-0x18(%ebp)
    1669:	74 06                	je     1671 <printf+0xb4>
    166b:	83 7d e8 70          	cmpl   $0x70,-0x18(%ebp)
    166f:	75 2d                	jne    169e <printf+0xe1>
    1671:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1674:	8b 00                	mov    (%eax),%eax
    1676:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    167d:	00 
    167e:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    1685:	00 
    1686:	89 44 24 04          	mov    %eax,0x4(%esp)
    168a:	8b 45 08             	mov    0x8(%ebp),%eax
    168d:	89 04 24             	mov    %eax,(%esp)
    1690:	e8 77 fe ff ff       	call   150c <printint>
    1695:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    1699:	e9 b4 00 00 00       	jmp    1752 <printf+0x195>
    169e:	83 7d e8 73          	cmpl   $0x73,-0x18(%ebp)
    16a2:	75 46                	jne    16ea <printf+0x12d>
    16a4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16a7:	8b 00                	mov    (%eax),%eax
    16a9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    16ac:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    16b0:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    16b4:	75 27                	jne    16dd <printf+0x120>
    16b6:	c7 45 e4 18 1c 00 00 	movl   $0x1c18,-0x1c(%ebp)
    16bd:	eb 1f                	jmp    16de <printf+0x121>
    16bf:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    16c2:	0f b6 00             	movzbl (%eax),%eax
    16c5:	0f be c0             	movsbl %al,%eax
    16c8:	89 44 24 04          	mov    %eax,0x4(%esp)
    16cc:	8b 45 08             	mov    0x8(%ebp),%eax
    16cf:	89 04 24             	mov    %eax,(%esp)
    16d2:	e8 0d fe ff ff       	call   14e4 <putc>
    16d7:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    16db:	eb 01                	jmp    16de <printf+0x121>
    16dd:	90                   	nop
    16de:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    16e1:	0f b6 00             	movzbl (%eax),%eax
    16e4:	84 c0                	test   %al,%al
    16e6:	75 d7                	jne    16bf <printf+0x102>
    16e8:	eb 68                	jmp    1752 <printf+0x195>
    16ea:	83 7d e8 63          	cmpl   $0x63,-0x18(%ebp)
    16ee:	75 1d                	jne    170d <printf+0x150>
    16f0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16f3:	8b 00                	mov    (%eax),%eax
    16f5:	0f be c0             	movsbl %al,%eax
    16f8:	89 44 24 04          	mov    %eax,0x4(%esp)
    16fc:	8b 45 08             	mov    0x8(%ebp),%eax
    16ff:	89 04 24             	mov    %eax,(%esp)
    1702:	e8 dd fd ff ff       	call   14e4 <putc>
    1707:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    170b:	eb 45                	jmp    1752 <printf+0x195>
    170d:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    1711:	75 17                	jne    172a <printf+0x16d>
    1713:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1716:	0f be c0             	movsbl %al,%eax
    1719:	89 44 24 04          	mov    %eax,0x4(%esp)
    171d:	8b 45 08             	mov    0x8(%ebp),%eax
    1720:	89 04 24             	mov    %eax,(%esp)
    1723:	e8 bc fd ff ff       	call   14e4 <putc>
    1728:	eb 28                	jmp    1752 <printf+0x195>
    172a:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
    1731:	00 
    1732:	8b 45 08             	mov    0x8(%ebp),%eax
    1735:	89 04 24             	mov    %eax,(%esp)
    1738:	e8 a7 fd ff ff       	call   14e4 <putc>
    173d:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1740:	0f be c0             	movsbl %al,%eax
    1743:	89 44 24 04          	mov    %eax,0x4(%esp)
    1747:	8b 45 08             	mov    0x8(%ebp),%eax
    174a:	89 04 24             	mov    %eax,(%esp)
    174d:	e8 92 fd ff ff       	call   14e4 <putc>
    1752:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1759:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    175d:	8b 55 0c             	mov    0xc(%ebp),%edx
    1760:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1763:	8d 04 02             	lea    (%edx,%eax,1),%eax
    1766:	0f b6 00             	movzbl (%eax),%eax
    1769:	84 c0                	test   %al,%al
    176b:	0f 85 6e fe ff ff    	jne    15df <printf+0x22>
    1771:	c9                   	leave  
    1772:	c3                   	ret    
    1773:	90                   	nop

00001774 <free>:
    1774:	55                   	push   %ebp
    1775:	89 e5                	mov    %esp,%ebp
    1777:	83 ec 10             	sub    $0x10,%esp
    177a:	8b 45 08             	mov    0x8(%ebp),%eax
    177d:	83 e8 08             	sub    $0x8,%eax
    1780:	89 45 f8             	mov    %eax,-0x8(%ebp)
    1783:	a1 6c 1c 00 00       	mov    0x1c6c,%eax
    1788:	89 45 fc             	mov    %eax,-0x4(%ebp)
    178b:	eb 24                	jmp    17b1 <free+0x3d>
    178d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1790:	8b 00                	mov    (%eax),%eax
    1792:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1795:	77 12                	ja     17a9 <free+0x35>
    1797:	8b 45 f8             	mov    -0x8(%ebp),%eax
    179a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    179d:	77 24                	ja     17c3 <free+0x4f>
    179f:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17a2:	8b 00                	mov    (%eax),%eax
    17a4:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    17a7:	77 1a                	ja     17c3 <free+0x4f>
    17a9:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17ac:	8b 00                	mov    (%eax),%eax
    17ae:	89 45 fc             	mov    %eax,-0x4(%ebp)
    17b1:	8b 45 f8             	mov    -0x8(%ebp),%eax
    17b4:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    17b7:	76 d4                	jbe    178d <free+0x19>
    17b9:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17bc:	8b 00                	mov    (%eax),%eax
    17be:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    17c1:	76 ca                	jbe    178d <free+0x19>
    17c3:	8b 45 f8             	mov    -0x8(%ebp),%eax
    17c6:	8b 40 04             	mov    0x4(%eax),%eax
    17c9:	c1 e0 03             	shl    $0x3,%eax
    17cc:	89 c2                	mov    %eax,%edx
    17ce:	03 55 f8             	add    -0x8(%ebp),%edx
    17d1:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17d4:	8b 00                	mov    (%eax),%eax
    17d6:	39 c2                	cmp    %eax,%edx
    17d8:	75 24                	jne    17fe <free+0x8a>
    17da:	8b 45 f8             	mov    -0x8(%ebp),%eax
    17dd:	8b 50 04             	mov    0x4(%eax),%edx
    17e0:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17e3:	8b 00                	mov    (%eax),%eax
    17e5:	8b 40 04             	mov    0x4(%eax),%eax
    17e8:	01 c2                	add    %eax,%edx
    17ea:	8b 45 f8             	mov    -0x8(%ebp),%eax
    17ed:	89 50 04             	mov    %edx,0x4(%eax)
    17f0:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17f3:	8b 00                	mov    (%eax),%eax
    17f5:	8b 10                	mov    (%eax),%edx
    17f7:	8b 45 f8             	mov    -0x8(%ebp),%eax
    17fa:	89 10                	mov    %edx,(%eax)
    17fc:	eb 0a                	jmp    1808 <free+0x94>
    17fe:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1801:	8b 10                	mov    (%eax),%edx
    1803:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1806:	89 10                	mov    %edx,(%eax)
    1808:	8b 45 fc             	mov    -0x4(%ebp),%eax
    180b:	8b 40 04             	mov    0x4(%eax),%eax
    180e:	c1 e0 03             	shl    $0x3,%eax
    1811:	03 45 fc             	add    -0x4(%ebp),%eax
    1814:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1817:	75 20                	jne    1839 <free+0xc5>
    1819:	8b 45 fc             	mov    -0x4(%ebp),%eax
    181c:	8b 50 04             	mov    0x4(%eax),%edx
    181f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1822:	8b 40 04             	mov    0x4(%eax),%eax
    1825:	01 c2                	add    %eax,%edx
    1827:	8b 45 fc             	mov    -0x4(%ebp),%eax
    182a:	89 50 04             	mov    %edx,0x4(%eax)
    182d:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1830:	8b 10                	mov    (%eax),%edx
    1832:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1835:	89 10                	mov    %edx,(%eax)
    1837:	eb 08                	jmp    1841 <free+0xcd>
    1839:	8b 45 fc             	mov    -0x4(%ebp),%eax
    183c:	8b 55 f8             	mov    -0x8(%ebp),%edx
    183f:	89 10                	mov    %edx,(%eax)
    1841:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1844:	a3 6c 1c 00 00       	mov    %eax,0x1c6c
    1849:	c9                   	leave  
    184a:	c3                   	ret    

0000184b <morecore>:
    184b:	55                   	push   %ebp
    184c:	89 e5                	mov    %esp,%ebp
    184e:	83 ec 28             	sub    $0x28,%esp
    1851:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    1858:	77 07                	ja     1861 <morecore+0x16>
    185a:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
    1861:	8b 45 08             	mov    0x8(%ebp),%eax
    1864:	c1 e0 03             	shl    $0x3,%eax
    1867:	89 04 24             	mov    %eax,(%esp)
    186a:	e8 35 fc ff ff       	call   14a4 <sbrk>
    186f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1872:	83 7d f0 ff          	cmpl   $0xffffffff,-0x10(%ebp)
    1876:	75 07                	jne    187f <morecore+0x34>
    1878:	b8 00 00 00 00       	mov    $0x0,%eax
    187d:	eb 22                	jmp    18a1 <morecore+0x56>
    187f:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1882:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1885:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1888:	8b 55 08             	mov    0x8(%ebp),%edx
    188b:	89 50 04             	mov    %edx,0x4(%eax)
    188e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1891:	83 c0 08             	add    $0x8,%eax
    1894:	89 04 24             	mov    %eax,(%esp)
    1897:	e8 d8 fe ff ff       	call   1774 <free>
    189c:	a1 6c 1c 00 00       	mov    0x1c6c,%eax
    18a1:	c9                   	leave  
    18a2:	c3                   	ret    

000018a3 <malloc>:
    18a3:	55                   	push   %ebp
    18a4:	89 e5                	mov    %esp,%ebp
    18a6:	83 ec 28             	sub    $0x28,%esp
    18a9:	8b 45 08             	mov    0x8(%ebp),%eax
    18ac:	83 c0 07             	add    $0x7,%eax
    18af:	c1 e8 03             	shr    $0x3,%eax
    18b2:	83 c0 01             	add    $0x1,%eax
    18b5:	89 45 f4             	mov    %eax,-0xc(%ebp)
    18b8:	a1 6c 1c 00 00       	mov    0x1c6c,%eax
    18bd:	89 45 f0             	mov    %eax,-0x10(%ebp)
    18c0:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    18c4:	75 23                	jne    18e9 <malloc+0x46>
    18c6:	c7 45 f0 64 1c 00 00 	movl   $0x1c64,-0x10(%ebp)
    18cd:	8b 45 f0             	mov    -0x10(%ebp),%eax
    18d0:	a3 6c 1c 00 00       	mov    %eax,0x1c6c
    18d5:	a1 6c 1c 00 00       	mov    0x1c6c,%eax
    18da:	a3 64 1c 00 00       	mov    %eax,0x1c64
    18df:	c7 05 68 1c 00 00 00 	movl   $0x0,0x1c68
    18e6:	00 00 00 
    18e9:	8b 45 f0             	mov    -0x10(%ebp),%eax
    18ec:	8b 00                	mov    (%eax),%eax
    18ee:	89 45 ec             	mov    %eax,-0x14(%ebp)
    18f1:	8b 45 ec             	mov    -0x14(%ebp),%eax
    18f4:	8b 40 04             	mov    0x4(%eax),%eax
    18f7:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    18fa:	72 4d                	jb     1949 <malloc+0xa6>
    18fc:	8b 45 ec             	mov    -0x14(%ebp),%eax
    18ff:	8b 40 04             	mov    0x4(%eax),%eax
    1902:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1905:	75 0c                	jne    1913 <malloc+0x70>
    1907:	8b 45 ec             	mov    -0x14(%ebp),%eax
    190a:	8b 10                	mov    (%eax),%edx
    190c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    190f:	89 10                	mov    %edx,(%eax)
    1911:	eb 26                	jmp    1939 <malloc+0x96>
    1913:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1916:	8b 40 04             	mov    0x4(%eax),%eax
    1919:	89 c2                	mov    %eax,%edx
    191b:	2b 55 f4             	sub    -0xc(%ebp),%edx
    191e:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1921:	89 50 04             	mov    %edx,0x4(%eax)
    1924:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1927:	8b 40 04             	mov    0x4(%eax),%eax
    192a:	c1 e0 03             	shl    $0x3,%eax
    192d:	01 45 ec             	add    %eax,-0x14(%ebp)
    1930:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1933:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1936:	89 50 04             	mov    %edx,0x4(%eax)
    1939:	8b 45 f0             	mov    -0x10(%ebp),%eax
    193c:	a3 6c 1c 00 00       	mov    %eax,0x1c6c
    1941:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1944:	83 c0 08             	add    $0x8,%eax
    1947:	eb 38                	jmp    1981 <malloc+0xde>
    1949:	a1 6c 1c 00 00       	mov    0x1c6c,%eax
    194e:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    1951:	75 1b                	jne    196e <malloc+0xcb>
    1953:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1956:	89 04 24             	mov    %eax,(%esp)
    1959:	e8 ed fe ff ff       	call   184b <morecore>
    195e:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1961:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1965:	75 07                	jne    196e <malloc+0xcb>
    1967:	b8 00 00 00 00       	mov    $0x0,%eax
    196c:	eb 13                	jmp    1981 <malloc+0xde>
    196e:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1971:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1974:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1977:	8b 00                	mov    (%eax),%eax
    1979:	89 45 ec             	mov    %eax,-0x14(%ebp)
    197c:	e9 70 ff ff ff       	jmp    18f1 <malloc+0x4e>
    1981:	c9                   	leave  
    1982:	c3                   	ret    
    1983:	90                   	nop

00001984 <xchg>:
    1984:	55                   	push   %ebp
    1985:	89 e5                	mov    %esp,%ebp
    1987:	83 ec 10             	sub    $0x10,%esp
    198a:	8b 55 08             	mov    0x8(%ebp),%edx
    198d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1990:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1993:	f0 87 02             	lock xchg %eax,(%edx)
    1996:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1999:	8b 45 fc             	mov    -0x4(%ebp),%eax
    199c:	c9                   	leave  
    199d:	c3                   	ret    

0000199e <lock_init>:
    199e:	55                   	push   %ebp
    199f:	89 e5                	mov    %esp,%ebp
    19a1:	8b 45 08             	mov    0x8(%ebp),%eax
    19a4:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    19aa:	5d                   	pop    %ebp
    19ab:	c3                   	ret    

000019ac <lock_acquire>:
    19ac:	55                   	push   %ebp
    19ad:	89 e5                	mov    %esp,%ebp
    19af:	83 ec 08             	sub    $0x8,%esp
    19b2:	8b 45 08             	mov    0x8(%ebp),%eax
    19b5:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    19bc:	00 
    19bd:	89 04 24             	mov    %eax,(%esp)
    19c0:	e8 bf ff ff ff       	call   1984 <xchg>
    19c5:	85 c0                	test   %eax,%eax
    19c7:	75 e9                	jne    19b2 <lock_acquire+0x6>
    19c9:	c9                   	leave  
    19ca:	c3                   	ret    

000019cb <lock_release>:
    19cb:	55                   	push   %ebp
    19cc:	89 e5                	mov    %esp,%ebp
    19ce:	83 ec 08             	sub    $0x8,%esp
    19d1:	8b 45 08             	mov    0x8(%ebp),%eax
    19d4:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    19db:	00 
    19dc:	89 04 24             	mov    %eax,(%esp)
    19df:	e8 a0 ff ff ff       	call   1984 <xchg>
    19e4:	c9                   	leave  
    19e5:	c3                   	ret    

000019e6 <thread_create>:
    19e6:	55                   	push   %ebp
    19e7:	89 e5                	mov    %esp,%ebp
    19e9:	83 ec 28             	sub    $0x28,%esp
    19ec:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
    19f3:	e8 ab fe ff ff       	call   18a3 <malloc>
    19f8:	89 45 f0             	mov    %eax,-0x10(%ebp)
    19fb:	8b 45 f0             	mov    -0x10(%ebp),%eax
    19fe:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1a01:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1a04:	25 ff 0f 00 00       	and    $0xfff,%eax
    1a09:	85 c0                	test   %eax,%eax
    1a0b:	74 15                	je     1a22 <thread_create+0x3c>
    1a0d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1a10:	89 c2                	mov    %eax,%edx
    1a12:	81 e2 ff 0f 00 00    	and    $0xfff,%edx
    1a18:	b8 00 10 00 00       	mov    $0x1000,%eax
    1a1d:	29 d0                	sub    %edx,%eax
    1a1f:	01 45 f0             	add    %eax,-0x10(%ebp)
    1a22:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1a26:	75 1b                	jne    1a43 <thread_create+0x5d>
    1a28:	c7 44 24 04 1f 1c 00 	movl   $0x1c1f,0x4(%esp)
    1a2f:	00 
    1a30:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1a37:	e8 81 fb ff ff       	call   15bd <printf>
    1a3c:	b8 00 00 00 00       	mov    $0x0,%eax
    1a41:	eb 6f                	jmp    1ab2 <thread_create+0xcc>
    1a43:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    1a46:	8b 55 08             	mov    0x8(%ebp),%edx
    1a49:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1a4c:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
    1a50:	89 54 24 08          	mov    %edx,0x8(%esp)
    1a54:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
    1a5b:	00 
    1a5c:	89 04 24             	mov    %eax,(%esp)
    1a5f:	e8 58 fa ff ff       	call   14bc <clone>
    1a64:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1a67:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1a6b:	79 1b                	jns    1a88 <thread_create+0xa2>
    1a6d:	c7 44 24 04 2d 1c 00 	movl   $0x1c2d,0x4(%esp)
    1a74:	00 
    1a75:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1a7c:	e8 3c fb ff ff       	call   15bd <printf>
    1a81:	b8 00 00 00 00       	mov    $0x0,%eax
    1a86:	eb 2a                	jmp    1ab2 <thread_create+0xcc>
    1a88:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1a8c:	7e 05                	jle    1a93 <thread_create+0xad>
    1a8e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a91:	eb 1f                	jmp    1ab2 <thread_create+0xcc>
    1a93:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1a97:	75 14                	jne    1aad <thread_create+0xc7>
    1a99:	c7 44 24 04 3a 1c 00 	movl   $0x1c3a,0x4(%esp)
    1aa0:	00 
    1aa1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1aa8:	e8 10 fb ff ff       	call   15bd <printf>
    1aad:	b8 00 00 00 00       	mov    $0x0,%eax
    1ab2:	c9                   	leave  
    1ab3:	c3                   	ret    

00001ab4 <random>:
    1ab4:	55                   	push   %ebp
    1ab5:	89 e5                	mov    %esp,%ebp
    1ab7:	a1 60 1c 00 00       	mov    0x1c60,%eax
    1abc:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
    1ac2:	05 69 f3 6e 3c       	add    $0x3c6ef369,%eax
    1ac7:	a3 60 1c 00 00       	mov    %eax,0x1c60
    1acc:	a1 60 1c 00 00       	mov    0x1c60,%eax
    1ad1:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1ad4:	ba 00 00 00 00       	mov    $0x0,%edx
    1ad9:	f7 f1                	div    %ecx
    1adb:	89 d0                	mov    %edx,%eax
    1add:	5d                   	pop    %ebp
    1ade:	c3                   	ret    
    1adf:	90                   	nop

00001ae0 <init_q>:
    1ae0:	55                   	push   %ebp
    1ae1:	89 e5                	mov    %esp,%ebp
    1ae3:	8b 45 08             	mov    0x8(%ebp),%eax
    1ae6:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    1aec:	8b 45 08             	mov    0x8(%ebp),%eax
    1aef:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    1af6:	8b 45 08             	mov    0x8(%ebp),%eax
    1af9:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
    1b00:	5d                   	pop    %ebp
    1b01:	c3                   	ret    

00001b02 <add_q>:
    1b02:	55                   	push   %ebp
    1b03:	89 e5                	mov    %esp,%ebp
    1b05:	83 ec 28             	sub    $0x28,%esp
    1b08:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
    1b0f:	e8 8f fd ff ff       	call   18a3 <malloc>
    1b14:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1b17:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b1a:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    1b21:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b24:	8b 55 0c             	mov    0xc(%ebp),%edx
    1b27:	89 10                	mov    %edx,(%eax)
    1b29:	8b 45 08             	mov    0x8(%ebp),%eax
    1b2c:	8b 40 04             	mov    0x4(%eax),%eax
    1b2f:	85 c0                	test   %eax,%eax
    1b31:	75 0b                	jne    1b3e <add_q+0x3c>
    1b33:	8b 45 08             	mov    0x8(%ebp),%eax
    1b36:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1b39:	89 50 04             	mov    %edx,0x4(%eax)
    1b3c:	eb 0c                	jmp    1b4a <add_q+0x48>
    1b3e:	8b 45 08             	mov    0x8(%ebp),%eax
    1b41:	8b 40 08             	mov    0x8(%eax),%eax
    1b44:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1b47:	89 50 04             	mov    %edx,0x4(%eax)
    1b4a:	8b 45 08             	mov    0x8(%ebp),%eax
    1b4d:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1b50:	89 50 08             	mov    %edx,0x8(%eax)
    1b53:	8b 45 08             	mov    0x8(%ebp),%eax
    1b56:	8b 00                	mov    (%eax),%eax
    1b58:	8d 50 01             	lea    0x1(%eax),%edx
    1b5b:	8b 45 08             	mov    0x8(%ebp),%eax
    1b5e:	89 10                	mov    %edx,(%eax)
    1b60:	c9                   	leave  
    1b61:	c3                   	ret    

00001b62 <empty_q>:
    1b62:	55                   	push   %ebp
    1b63:	89 e5                	mov    %esp,%ebp
    1b65:	8b 45 08             	mov    0x8(%ebp),%eax
    1b68:	8b 00                	mov    (%eax),%eax
    1b6a:	85 c0                	test   %eax,%eax
    1b6c:	75 07                	jne    1b75 <empty_q+0x13>
    1b6e:	b8 01 00 00 00       	mov    $0x1,%eax
    1b73:	eb 05                	jmp    1b7a <empty_q+0x18>
    1b75:	b8 00 00 00 00       	mov    $0x0,%eax
    1b7a:	5d                   	pop    %ebp
    1b7b:	c3                   	ret    

00001b7c <pop_q>:
    1b7c:	55                   	push   %ebp
    1b7d:	89 e5                	mov    %esp,%ebp
    1b7f:	83 ec 28             	sub    $0x28,%esp
    1b82:	8b 45 08             	mov    0x8(%ebp),%eax
    1b85:	89 04 24             	mov    %eax,(%esp)
    1b88:	e8 d5 ff ff ff       	call   1b62 <empty_q>
    1b8d:	85 c0                	test   %eax,%eax
    1b8f:	75 5d                	jne    1bee <pop_q+0x72>
    1b91:	8b 45 08             	mov    0x8(%ebp),%eax
    1b94:	8b 40 04             	mov    0x4(%eax),%eax
    1b97:	8b 00                	mov    (%eax),%eax
    1b99:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1b9c:	8b 45 08             	mov    0x8(%ebp),%eax
    1b9f:	8b 40 04             	mov    0x4(%eax),%eax
    1ba2:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1ba5:	8b 45 08             	mov    0x8(%ebp),%eax
    1ba8:	8b 40 04             	mov    0x4(%eax),%eax
    1bab:	8b 50 04             	mov    0x4(%eax),%edx
    1bae:	8b 45 08             	mov    0x8(%ebp),%eax
    1bb1:	89 50 04             	mov    %edx,0x4(%eax)
    1bb4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1bb7:	89 04 24             	mov    %eax,(%esp)
    1bba:	e8 b5 fb ff ff       	call   1774 <free>
    1bbf:	8b 45 08             	mov    0x8(%ebp),%eax
    1bc2:	8b 00                	mov    (%eax),%eax
    1bc4:	8d 50 ff             	lea    -0x1(%eax),%edx
    1bc7:	8b 45 08             	mov    0x8(%ebp),%eax
    1bca:	89 10                	mov    %edx,(%eax)
    1bcc:	8b 45 08             	mov    0x8(%ebp),%eax
    1bcf:	8b 00                	mov    (%eax),%eax
    1bd1:	85 c0                	test   %eax,%eax
    1bd3:	75 14                	jne    1be9 <pop_q+0x6d>
    1bd5:	8b 45 08             	mov    0x8(%ebp),%eax
    1bd8:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    1bdf:	8b 45 08             	mov    0x8(%ebp),%eax
    1be2:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
    1be9:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1bec:	eb 05                	jmp    1bf3 <pop_q+0x77>
    1bee:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1bf3:	c9                   	leave  
    1bf4:	c3                   	ret    
