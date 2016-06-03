
_wc:     file format elf32-i386


Disassembly of section .text:

00001000 <wc>:
    1000:	55                   	push   %ebp
    1001:	89 e5                	mov    %esp,%ebp
    1003:	83 ec 48             	sub    $0x48,%esp
    1006:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    100d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1010:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1013:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1016:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1019:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1020:	eb 66                	jmp    1088 <wc+0x88>
    1022:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    1029:	eb 55                	jmp    1080 <wc+0x80>
    102b:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    102f:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1032:	0f b6 80 c0 1c 00 00 	movzbl 0x1cc0(%eax),%eax
    1039:	3c 0a                	cmp    $0xa,%al
    103b:	75 04                	jne    1041 <wc+0x41>
    103d:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    1041:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1044:	0f b6 80 c0 1c 00 00 	movzbl 0x1cc0(%eax),%eax
    104b:	0f be c0             	movsbl %al,%eax
    104e:	89 44 24 04          	mov    %eax,0x4(%esp)
    1052:	c7 04 24 01 1c 00 00 	movl   $0x1c01,(%esp)
    1059:	e8 48 02 00 00       	call   12a6 <strchr>
    105e:	85 c0                	test   %eax,%eax
    1060:	74 09                	je     106b <wc+0x6b>
    1062:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1069:	eb 11                	jmp    107c <wc+0x7c>
    106b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    106f:	75 0b                	jne    107c <wc+0x7c>
    1071:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1075:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
    107c:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    1080:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1083:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
    1086:	7c a3                	jl     102b <wc+0x2b>
    1088:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
    108f:	00 
    1090:	c7 44 24 04 c0 1c 00 	movl   $0x1cc0,0x4(%esp)
    1097:	00 
    1098:	8b 45 08             	mov    0x8(%ebp),%eax
    109b:	89 04 24             	mov    %eax,(%esp)
    109e:	e8 9d 03 00 00       	call   1440 <read>
    10a3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    10a6:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    10aa:	0f 8f 72 ff ff ff    	jg     1022 <wc+0x22>
    10b0:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    10b4:	79 19                	jns    10cf <wc+0xcf>
    10b6:	c7 44 24 04 07 1c 00 	movl   $0x1c07,0x4(%esp)
    10bd:	00 
    10be:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    10c5:	e8 ff 04 00 00       	call   15c9 <printf>
    10ca:	e8 59 03 00 00       	call   1428 <exit>
    10cf:	8b 45 0c             	mov    0xc(%ebp),%eax
    10d2:	89 44 24 14          	mov    %eax,0x14(%esp)
    10d6:	8b 45 f0             	mov    -0x10(%ebp),%eax
    10d9:	89 44 24 10          	mov    %eax,0x10(%esp)
    10dd:	8b 45 ec             	mov    -0x14(%ebp),%eax
    10e0:	89 44 24 0c          	mov    %eax,0xc(%esp)
    10e4:	8b 45 e8             	mov    -0x18(%ebp),%eax
    10e7:	89 44 24 08          	mov    %eax,0x8(%esp)
    10eb:	c7 44 24 04 17 1c 00 	movl   $0x1c17,0x4(%esp)
    10f2:	00 
    10f3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    10fa:	e8 ca 04 00 00       	call   15c9 <printf>
    10ff:	c9                   	leave  
    1100:	c3                   	ret    

00001101 <main>:
    1101:	55                   	push   %ebp
    1102:	89 e5                	mov    %esp,%ebp
    1104:	83 e4 f0             	and    $0xfffffff0,%esp
    1107:	83 ec 20             	sub    $0x20,%esp
    110a:	83 7d 08 01          	cmpl   $0x1,0x8(%ebp)
    110e:	7f 19                	jg     1129 <main+0x28>
    1110:	c7 44 24 04 24 1c 00 	movl   $0x1c24,0x4(%esp)
    1117:	00 
    1118:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    111f:	e8 dc fe ff ff       	call   1000 <wc>
    1124:	e8 ff 02 00 00       	call   1428 <exit>
    1129:	c7 44 24 1c 01 00 00 	movl   $0x1,0x1c(%esp)
    1130:	00 
    1131:	eb 7d                	jmp    11b0 <main+0xaf>
    1133:	8b 44 24 1c          	mov    0x1c(%esp),%eax
    1137:	c1 e0 02             	shl    $0x2,%eax
    113a:	03 45 0c             	add    0xc(%ebp),%eax
    113d:	8b 00                	mov    (%eax),%eax
    113f:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1146:	00 
    1147:	89 04 24             	mov    %eax,(%esp)
    114a:	e8 19 03 00 00       	call   1468 <open>
    114f:	89 44 24 18          	mov    %eax,0x18(%esp)
    1153:	83 7c 24 18 00       	cmpl   $0x0,0x18(%esp)
    1158:	79 29                	jns    1183 <main+0x82>
    115a:	8b 44 24 1c          	mov    0x1c(%esp),%eax
    115e:	c1 e0 02             	shl    $0x2,%eax
    1161:	03 45 0c             	add    0xc(%ebp),%eax
    1164:	8b 00                	mov    (%eax),%eax
    1166:	89 44 24 08          	mov    %eax,0x8(%esp)
    116a:	c7 44 24 04 25 1c 00 	movl   $0x1c25,0x4(%esp)
    1171:	00 
    1172:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1179:	e8 4b 04 00 00       	call   15c9 <printf>
    117e:	e8 a5 02 00 00       	call   1428 <exit>
    1183:	8b 44 24 1c          	mov    0x1c(%esp),%eax
    1187:	c1 e0 02             	shl    $0x2,%eax
    118a:	03 45 0c             	add    0xc(%ebp),%eax
    118d:	8b 00                	mov    (%eax),%eax
    118f:	89 44 24 04          	mov    %eax,0x4(%esp)
    1193:	8b 44 24 18          	mov    0x18(%esp),%eax
    1197:	89 04 24             	mov    %eax,(%esp)
    119a:	e8 61 fe ff ff       	call   1000 <wc>
    119f:	8b 44 24 18          	mov    0x18(%esp),%eax
    11a3:	89 04 24             	mov    %eax,(%esp)
    11a6:	e8 a5 02 00 00       	call   1450 <close>
    11ab:	83 44 24 1c 01       	addl   $0x1,0x1c(%esp)
    11b0:	8b 44 24 1c          	mov    0x1c(%esp),%eax
    11b4:	3b 45 08             	cmp    0x8(%ebp),%eax
    11b7:	0f 8c 76 ff ff ff    	jl     1133 <main+0x32>
    11bd:	e8 66 02 00 00       	call   1428 <exit>
    11c2:	90                   	nop
    11c3:	90                   	nop

000011c4 <stosb>:
    11c4:	55                   	push   %ebp
    11c5:	89 e5                	mov    %esp,%ebp
    11c7:	57                   	push   %edi
    11c8:	53                   	push   %ebx
    11c9:	8b 4d 08             	mov    0x8(%ebp),%ecx
    11cc:	8b 55 10             	mov    0x10(%ebp),%edx
    11cf:	8b 45 0c             	mov    0xc(%ebp),%eax
    11d2:	89 cb                	mov    %ecx,%ebx
    11d4:	89 df                	mov    %ebx,%edi
    11d6:	89 d1                	mov    %edx,%ecx
    11d8:	fc                   	cld    
    11d9:	f3 aa                	rep stos %al,%es:(%edi)
    11db:	89 ca                	mov    %ecx,%edx
    11dd:	89 fb                	mov    %edi,%ebx
    11df:	89 5d 08             	mov    %ebx,0x8(%ebp)
    11e2:	89 55 10             	mov    %edx,0x10(%ebp)
    11e5:	5b                   	pop    %ebx
    11e6:	5f                   	pop    %edi
    11e7:	5d                   	pop    %ebp
    11e8:	c3                   	ret    

000011e9 <strcpy>:
    11e9:	55                   	push   %ebp
    11ea:	89 e5                	mov    %esp,%ebp
    11ec:	83 ec 10             	sub    $0x10,%esp
    11ef:	8b 45 08             	mov    0x8(%ebp),%eax
    11f2:	89 45 fc             	mov    %eax,-0x4(%ebp)
    11f5:	8b 45 0c             	mov    0xc(%ebp),%eax
    11f8:	0f b6 10             	movzbl (%eax),%edx
    11fb:	8b 45 08             	mov    0x8(%ebp),%eax
    11fe:	88 10                	mov    %dl,(%eax)
    1200:	8b 45 08             	mov    0x8(%ebp),%eax
    1203:	0f b6 00             	movzbl (%eax),%eax
    1206:	84 c0                	test   %al,%al
    1208:	0f 95 c0             	setne  %al
    120b:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    120f:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
    1213:	84 c0                	test   %al,%al
    1215:	75 de                	jne    11f5 <strcpy+0xc>
    1217:	8b 45 fc             	mov    -0x4(%ebp),%eax
    121a:	c9                   	leave  
    121b:	c3                   	ret    

0000121c <strcmp>:
    121c:	55                   	push   %ebp
    121d:	89 e5                	mov    %esp,%ebp
    121f:	eb 08                	jmp    1229 <strcmp+0xd>
    1221:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1225:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
    1229:	8b 45 08             	mov    0x8(%ebp),%eax
    122c:	0f b6 00             	movzbl (%eax),%eax
    122f:	84 c0                	test   %al,%al
    1231:	74 10                	je     1243 <strcmp+0x27>
    1233:	8b 45 08             	mov    0x8(%ebp),%eax
    1236:	0f b6 10             	movzbl (%eax),%edx
    1239:	8b 45 0c             	mov    0xc(%ebp),%eax
    123c:	0f b6 00             	movzbl (%eax),%eax
    123f:	38 c2                	cmp    %al,%dl
    1241:	74 de                	je     1221 <strcmp+0x5>
    1243:	8b 45 08             	mov    0x8(%ebp),%eax
    1246:	0f b6 00             	movzbl (%eax),%eax
    1249:	0f b6 d0             	movzbl %al,%edx
    124c:	8b 45 0c             	mov    0xc(%ebp),%eax
    124f:	0f b6 00             	movzbl (%eax),%eax
    1252:	0f b6 c0             	movzbl %al,%eax
    1255:	89 d1                	mov    %edx,%ecx
    1257:	29 c1                	sub    %eax,%ecx
    1259:	89 c8                	mov    %ecx,%eax
    125b:	5d                   	pop    %ebp
    125c:	c3                   	ret    

0000125d <strlen>:
    125d:	55                   	push   %ebp
    125e:	89 e5                	mov    %esp,%ebp
    1260:	83 ec 10             	sub    $0x10,%esp
    1263:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    126a:	eb 04                	jmp    1270 <strlen+0x13>
    126c:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    1270:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1273:	03 45 08             	add    0x8(%ebp),%eax
    1276:	0f b6 00             	movzbl (%eax),%eax
    1279:	84 c0                	test   %al,%al
    127b:	75 ef                	jne    126c <strlen+0xf>
    127d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1280:	c9                   	leave  
    1281:	c3                   	ret    

00001282 <memset>:
    1282:	55                   	push   %ebp
    1283:	89 e5                	mov    %esp,%ebp
    1285:	83 ec 0c             	sub    $0xc,%esp
    1288:	8b 45 10             	mov    0x10(%ebp),%eax
    128b:	89 44 24 08          	mov    %eax,0x8(%esp)
    128f:	8b 45 0c             	mov    0xc(%ebp),%eax
    1292:	89 44 24 04          	mov    %eax,0x4(%esp)
    1296:	8b 45 08             	mov    0x8(%ebp),%eax
    1299:	89 04 24             	mov    %eax,(%esp)
    129c:	e8 23 ff ff ff       	call   11c4 <stosb>
    12a1:	8b 45 08             	mov    0x8(%ebp),%eax
    12a4:	c9                   	leave  
    12a5:	c3                   	ret    

000012a6 <strchr>:
    12a6:	55                   	push   %ebp
    12a7:	89 e5                	mov    %esp,%ebp
    12a9:	83 ec 04             	sub    $0x4,%esp
    12ac:	8b 45 0c             	mov    0xc(%ebp),%eax
    12af:	88 45 fc             	mov    %al,-0x4(%ebp)
    12b2:	eb 14                	jmp    12c8 <strchr+0x22>
    12b4:	8b 45 08             	mov    0x8(%ebp),%eax
    12b7:	0f b6 00             	movzbl (%eax),%eax
    12ba:	3a 45 fc             	cmp    -0x4(%ebp),%al
    12bd:	75 05                	jne    12c4 <strchr+0x1e>
    12bf:	8b 45 08             	mov    0x8(%ebp),%eax
    12c2:	eb 13                	jmp    12d7 <strchr+0x31>
    12c4:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    12c8:	8b 45 08             	mov    0x8(%ebp),%eax
    12cb:	0f b6 00             	movzbl (%eax),%eax
    12ce:	84 c0                	test   %al,%al
    12d0:	75 e2                	jne    12b4 <strchr+0xe>
    12d2:	b8 00 00 00 00       	mov    $0x0,%eax
    12d7:	c9                   	leave  
    12d8:	c3                   	ret    

000012d9 <gets>:
    12d9:	55                   	push   %ebp
    12da:	89 e5                	mov    %esp,%ebp
    12dc:	83 ec 28             	sub    $0x28,%esp
    12df:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    12e6:	eb 44                	jmp    132c <gets+0x53>
    12e8:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    12ef:	00 
    12f0:	8d 45 ef             	lea    -0x11(%ebp),%eax
    12f3:	89 44 24 04          	mov    %eax,0x4(%esp)
    12f7:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    12fe:	e8 3d 01 00 00       	call   1440 <read>
    1303:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1306:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    130a:	7e 2d                	jle    1339 <gets+0x60>
    130c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    130f:	03 45 08             	add    0x8(%ebp),%eax
    1312:	0f b6 55 ef          	movzbl -0x11(%ebp),%edx
    1316:	88 10                	mov    %dl,(%eax)
    1318:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    131c:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    1320:	3c 0a                	cmp    $0xa,%al
    1322:	74 16                	je     133a <gets+0x61>
    1324:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    1328:	3c 0d                	cmp    $0xd,%al
    132a:	74 0e                	je     133a <gets+0x61>
    132c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    132f:	83 c0 01             	add    $0x1,%eax
    1332:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1335:	7c b1                	jl     12e8 <gets+0xf>
    1337:	eb 01                	jmp    133a <gets+0x61>
    1339:	90                   	nop
    133a:	8b 45 f0             	mov    -0x10(%ebp),%eax
    133d:	03 45 08             	add    0x8(%ebp),%eax
    1340:	c6 00 00             	movb   $0x0,(%eax)
    1343:	8b 45 08             	mov    0x8(%ebp),%eax
    1346:	c9                   	leave  
    1347:	c3                   	ret    

00001348 <stat>:
    1348:	55                   	push   %ebp
    1349:	89 e5                	mov    %esp,%ebp
    134b:	83 ec 28             	sub    $0x28,%esp
    134e:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1355:	00 
    1356:	8b 45 08             	mov    0x8(%ebp),%eax
    1359:	89 04 24             	mov    %eax,(%esp)
    135c:	e8 07 01 00 00       	call   1468 <open>
    1361:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1364:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1368:	79 07                	jns    1371 <stat+0x29>
    136a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    136f:	eb 23                	jmp    1394 <stat+0x4c>
    1371:	8b 45 0c             	mov    0xc(%ebp),%eax
    1374:	89 44 24 04          	mov    %eax,0x4(%esp)
    1378:	8b 45 f0             	mov    -0x10(%ebp),%eax
    137b:	89 04 24             	mov    %eax,(%esp)
    137e:	e8 fd 00 00 00       	call   1480 <fstat>
    1383:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1386:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1389:	89 04 24             	mov    %eax,(%esp)
    138c:	e8 bf 00 00 00       	call   1450 <close>
    1391:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1394:	c9                   	leave  
    1395:	c3                   	ret    

00001396 <atoi>:
    1396:	55                   	push   %ebp
    1397:	89 e5                	mov    %esp,%ebp
    1399:	83 ec 10             	sub    $0x10,%esp
    139c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    13a3:	eb 24                	jmp    13c9 <atoi+0x33>
    13a5:	8b 55 fc             	mov    -0x4(%ebp),%edx
    13a8:	89 d0                	mov    %edx,%eax
    13aa:	c1 e0 02             	shl    $0x2,%eax
    13ad:	01 d0                	add    %edx,%eax
    13af:	01 c0                	add    %eax,%eax
    13b1:	89 c2                	mov    %eax,%edx
    13b3:	8b 45 08             	mov    0x8(%ebp),%eax
    13b6:	0f b6 00             	movzbl (%eax),%eax
    13b9:	0f be c0             	movsbl %al,%eax
    13bc:	8d 04 02             	lea    (%edx,%eax,1),%eax
    13bf:	83 e8 30             	sub    $0x30,%eax
    13c2:	89 45 fc             	mov    %eax,-0x4(%ebp)
    13c5:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    13c9:	8b 45 08             	mov    0x8(%ebp),%eax
    13cc:	0f b6 00             	movzbl (%eax),%eax
    13cf:	3c 2f                	cmp    $0x2f,%al
    13d1:	7e 0a                	jle    13dd <atoi+0x47>
    13d3:	8b 45 08             	mov    0x8(%ebp),%eax
    13d6:	0f b6 00             	movzbl (%eax),%eax
    13d9:	3c 39                	cmp    $0x39,%al
    13db:	7e c8                	jle    13a5 <atoi+0xf>
    13dd:	8b 45 fc             	mov    -0x4(%ebp),%eax
    13e0:	c9                   	leave  
    13e1:	c3                   	ret    

000013e2 <memmove>:
    13e2:	55                   	push   %ebp
    13e3:	89 e5                	mov    %esp,%ebp
    13e5:	83 ec 10             	sub    $0x10,%esp
    13e8:	8b 45 08             	mov    0x8(%ebp),%eax
    13eb:	89 45 f8             	mov    %eax,-0x8(%ebp)
    13ee:	8b 45 0c             	mov    0xc(%ebp),%eax
    13f1:	89 45 fc             	mov    %eax,-0x4(%ebp)
    13f4:	eb 13                	jmp    1409 <memmove+0x27>
    13f6:	8b 45 fc             	mov    -0x4(%ebp),%eax
    13f9:	0f b6 10             	movzbl (%eax),%edx
    13fc:	8b 45 f8             	mov    -0x8(%ebp),%eax
    13ff:	88 10                	mov    %dl,(%eax)
    1401:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    1405:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    1409:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    140d:	0f 9f c0             	setg   %al
    1410:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
    1414:	84 c0                	test   %al,%al
    1416:	75 de                	jne    13f6 <memmove+0x14>
    1418:	8b 45 08             	mov    0x8(%ebp),%eax
    141b:	c9                   	leave  
    141c:	c3                   	ret    
    141d:	90                   	nop
    141e:	90                   	nop
    141f:	90                   	nop

00001420 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    1420:	b8 01 00 00 00       	mov    $0x1,%eax
    1425:	cd 40                	int    $0x40
    1427:	c3                   	ret    

00001428 <exit>:
SYSCALL(exit)
    1428:	b8 02 00 00 00       	mov    $0x2,%eax
    142d:	cd 40                	int    $0x40
    142f:	c3                   	ret    

00001430 <wait>:
SYSCALL(wait)
    1430:	b8 03 00 00 00       	mov    $0x3,%eax
    1435:	cd 40                	int    $0x40
    1437:	c3                   	ret    

00001438 <pipe>:
SYSCALL(pipe)
    1438:	b8 04 00 00 00       	mov    $0x4,%eax
    143d:	cd 40                	int    $0x40
    143f:	c3                   	ret    

00001440 <read>:
SYSCALL(read)
    1440:	b8 05 00 00 00       	mov    $0x5,%eax
    1445:	cd 40                	int    $0x40
    1447:	c3                   	ret    

00001448 <write>:
SYSCALL(write)
    1448:	b8 10 00 00 00       	mov    $0x10,%eax
    144d:	cd 40                	int    $0x40
    144f:	c3                   	ret    

00001450 <close>:
SYSCALL(close)
    1450:	b8 15 00 00 00       	mov    $0x15,%eax
    1455:	cd 40                	int    $0x40
    1457:	c3                   	ret    

00001458 <kill>:
SYSCALL(kill)
    1458:	b8 06 00 00 00       	mov    $0x6,%eax
    145d:	cd 40                	int    $0x40
    145f:	c3                   	ret    

00001460 <exec>:
SYSCALL(exec)
    1460:	b8 07 00 00 00       	mov    $0x7,%eax
    1465:	cd 40                	int    $0x40
    1467:	c3                   	ret    

00001468 <open>:
SYSCALL(open)
    1468:	b8 0f 00 00 00       	mov    $0xf,%eax
    146d:	cd 40                	int    $0x40
    146f:	c3                   	ret    

00001470 <mknod>:
SYSCALL(mknod)
    1470:	b8 11 00 00 00       	mov    $0x11,%eax
    1475:	cd 40                	int    $0x40
    1477:	c3                   	ret    

00001478 <unlink>:
SYSCALL(unlink)
    1478:	b8 12 00 00 00       	mov    $0x12,%eax
    147d:	cd 40                	int    $0x40
    147f:	c3                   	ret    

00001480 <fstat>:
SYSCALL(fstat)
    1480:	b8 08 00 00 00       	mov    $0x8,%eax
    1485:	cd 40                	int    $0x40
    1487:	c3                   	ret    

00001488 <link>:
SYSCALL(link)
    1488:	b8 13 00 00 00       	mov    $0x13,%eax
    148d:	cd 40                	int    $0x40
    148f:	c3                   	ret    

00001490 <mkdir>:
SYSCALL(mkdir)
    1490:	b8 14 00 00 00       	mov    $0x14,%eax
    1495:	cd 40                	int    $0x40
    1497:	c3                   	ret    

00001498 <chdir>:
SYSCALL(chdir)
    1498:	b8 09 00 00 00       	mov    $0x9,%eax
    149d:	cd 40                	int    $0x40
    149f:	c3                   	ret    

000014a0 <dup>:
SYSCALL(dup)
    14a0:	b8 0a 00 00 00       	mov    $0xa,%eax
    14a5:	cd 40                	int    $0x40
    14a7:	c3                   	ret    

000014a8 <getpid>:
SYSCALL(getpid)
    14a8:	b8 0b 00 00 00       	mov    $0xb,%eax
    14ad:	cd 40                	int    $0x40
    14af:	c3                   	ret    

000014b0 <sbrk>:
SYSCALL(sbrk)
    14b0:	b8 0c 00 00 00       	mov    $0xc,%eax
    14b5:	cd 40                	int    $0x40
    14b7:	c3                   	ret    

000014b8 <sleep>:
SYSCALL(sleep)
    14b8:	b8 0d 00 00 00       	mov    $0xd,%eax
    14bd:	cd 40                	int    $0x40
    14bf:	c3                   	ret    

000014c0 <uptime>:
SYSCALL(uptime)
    14c0:	b8 0e 00 00 00       	mov    $0xe,%eax
    14c5:	cd 40                	int    $0x40
    14c7:	c3                   	ret    

000014c8 <clone>:
SYSCALL(clone)
    14c8:	b8 16 00 00 00       	mov    $0x16,%eax
    14cd:	cd 40                	int    $0x40
    14cf:	c3                   	ret    

000014d0 <texit>:
SYSCALL(texit)
    14d0:	b8 17 00 00 00       	mov    $0x17,%eax
    14d5:	cd 40                	int    $0x40
    14d7:	c3                   	ret    

000014d8 <tsleep>:
SYSCALL(tsleep)
    14d8:	b8 18 00 00 00       	mov    $0x18,%eax
    14dd:	cd 40                	int    $0x40
    14df:	c3                   	ret    

000014e0 <twakeup>:
SYSCALL(twakeup)
    14e0:	b8 19 00 00 00       	mov    $0x19,%eax
    14e5:	cd 40                	int    $0x40
    14e7:	c3                   	ret    

000014e8 <thread_yield>:
SYSCALL(thread_yield)
    14e8:	b8 1a 00 00 00       	mov    $0x1a,%eax
    14ed:	cd 40                	int    $0x40
    14ef:	c3                   	ret    

000014f0 <putc>:
    14f0:	55                   	push   %ebp
    14f1:	89 e5                	mov    %esp,%ebp
    14f3:	83 ec 28             	sub    $0x28,%esp
    14f6:	8b 45 0c             	mov    0xc(%ebp),%eax
    14f9:	88 45 f4             	mov    %al,-0xc(%ebp)
    14fc:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1503:	00 
    1504:	8d 45 f4             	lea    -0xc(%ebp),%eax
    1507:	89 44 24 04          	mov    %eax,0x4(%esp)
    150b:	8b 45 08             	mov    0x8(%ebp),%eax
    150e:	89 04 24             	mov    %eax,(%esp)
    1511:	e8 32 ff ff ff       	call   1448 <write>
    1516:	c9                   	leave  
    1517:	c3                   	ret    

00001518 <printint>:
    1518:	55                   	push   %ebp
    1519:	89 e5                	mov    %esp,%ebp
    151b:	53                   	push   %ebx
    151c:	83 ec 44             	sub    $0x44,%esp
    151f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1526:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    152a:	74 17                	je     1543 <printint+0x2b>
    152c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1530:	79 11                	jns    1543 <printint+0x2b>
    1532:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    1539:	8b 45 0c             	mov    0xc(%ebp),%eax
    153c:	f7 d8                	neg    %eax
    153e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1541:	eb 06                	jmp    1549 <printint+0x31>
    1543:	8b 45 0c             	mov    0xc(%ebp),%eax
    1546:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1549:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    1550:	8b 4d ec             	mov    -0x14(%ebp),%ecx
    1553:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1556:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1559:	ba 00 00 00 00       	mov    $0x0,%edx
    155e:	f7 f3                	div    %ebx
    1560:	89 d0                	mov    %edx,%eax
    1562:	0f b6 80 6c 1c 00 00 	movzbl 0x1c6c(%eax),%eax
    1569:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
    156d:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1571:	8b 45 10             	mov    0x10(%ebp),%eax
    1574:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    1577:	8b 45 f4             	mov    -0xc(%ebp),%eax
    157a:	ba 00 00 00 00       	mov    $0x0,%edx
    157f:	f7 75 d4             	divl   -0x2c(%ebp)
    1582:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1585:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1589:	75 c5                	jne    1550 <printint+0x38>
    158b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    158f:	74 28                	je     15b9 <printint+0xa1>
    1591:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1594:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)
    1599:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    159d:	eb 1a                	jmp    15b9 <printint+0xa1>
    159f:	8b 45 ec             	mov    -0x14(%ebp),%eax
    15a2:	0f b6 44 05 dc       	movzbl -0x24(%ebp,%eax,1),%eax
    15a7:	0f be c0             	movsbl %al,%eax
    15aa:	89 44 24 04          	mov    %eax,0x4(%esp)
    15ae:	8b 45 08             	mov    0x8(%ebp),%eax
    15b1:	89 04 24             	mov    %eax,(%esp)
    15b4:	e8 37 ff ff ff       	call   14f0 <putc>
    15b9:	83 6d ec 01          	subl   $0x1,-0x14(%ebp)
    15bd:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    15c1:	79 dc                	jns    159f <printint+0x87>
    15c3:	83 c4 44             	add    $0x44,%esp
    15c6:	5b                   	pop    %ebx
    15c7:	5d                   	pop    %ebp
    15c8:	c3                   	ret    

000015c9 <printf>:
    15c9:	55                   	push   %ebp
    15ca:	89 e5                	mov    %esp,%ebp
    15cc:	83 ec 38             	sub    $0x38,%esp
    15cf:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    15d6:	8d 45 0c             	lea    0xc(%ebp),%eax
    15d9:	83 c0 04             	add    $0x4,%eax
    15dc:	89 45 f4             	mov    %eax,-0xc(%ebp)
    15df:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    15e6:	e9 7e 01 00 00       	jmp    1769 <printf+0x1a0>
    15eb:	8b 55 0c             	mov    0xc(%ebp),%edx
    15ee:	8b 45 ec             	mov    -0x14(%ebp),%eax
    15f1:	8d 04 02             	lea    (%edx,%eax,1),%eax
    15f4:	0f b6 00             	movzbl (%eax),%eax
    15f7:	0f be c0             	movsbl %al,%eax
    15fa:	25 ff 00 00 00       	and    $0xff,%eax
    15ff:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1602:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1606:	75 2c                	jne    1634 <printf+0x6b>
    1608:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    160c:	75 0c                	jne    161a <printf+0x51>
    160e:	c7 45 f0 25 00 00 00 	movl   $0x25,-0x10(%ebp)
    1615:	e9 4b 01 00 00       	jmp    1765 <printf+0x19c>
    161a:	8b 45 e8             	mov    -0x18(%ebp),%eax
    161d:	0f be c0             	movsbl %al,%eax
    1620:	89 44 24 04          	mov    %eax,0x4(%esp)
    1624:	8b 45 08             	mov    0x8(%ebp),%eax
    1627:	89 04 24             	mov    %eax,(%esp)
    162a:	e8 c1 fe ff ff       	call   14f0 <putc>
    162f:	e9 31 01 00 00       	jmp    1765 <printf+0x19c>
    1634:	83 7d f0 25          	cmpl   $0x25,-0x10(%ebp)
    1638:	0f 85 27 01 00 00    	jne    1765 <printf+0x19c>
    163e:	83 7d e8 64          	cmpl   $0x64,-0x18(%ebp)
    1642:	75 2d                	jne    1671 <printf+0xa8>
    1644:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1647:	8b 00                	mov    (%eax),%eax
    1649:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
    1650:	00 
    1651:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    1658:	00 
    1659:	89 44 24 04          	mov    %eax,0x4(%esp)
    165d:	8b 45 08             	mov    0x8(%ebp),%eax
    1660:	89 04 24             	mov    %eax,(%esp)
    1663:	e8 b0 fe ff ff       	call   1518 <printint>
    1668:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    166c:	e9 ed 00 00 00       	jmp    175e <printf+0x195>
    1671:	83 7d e8 78          	cmpl   $0x78,-0x18(%ebp)
    1675:	74 06                	je     167d <printf+0xb4>
    1677:	83 7d e8 70          	cmpl   $0x70,-0x18(%ebp)
    167b:	75 2d                	jne    16aa <printf+0xe1>
    167d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1680:	8b 00                	mov    (%eax),%eax
    1682:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    1689:	00 
    168a:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    1691:	00 
    1692:	89 44 24 04          	mov    %eax,0x4(%esp)
    1696:	8b 45 08             	mov    0x8(%ebp),%eax
    1699:	89 04 24             	mov    %eax,(%esp)
    169c:	e8 77 fe ff ff       	call   1518 <printint>
    16a1:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    16a5:	e9 b4 00 00 00       	jmp    175e <printf+0x195>
    16aa:	83 7d e8 73          	cmpl   $0x73,-0x18(%ebp)
    16ae:	75 46                	jne    16f6 <printf+0x12d>
    16b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16b3:	8b 00                	mov    (%eax),%eax
    16b5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    16b8:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    16bc:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    16c0:	75 27                	jne    16e9 <printf+0x120>
    16c2:	c7 45 e4 39 1c 00 00 	movl   $0x1c39,-0x1c(%ebp)
    16c9:	eb 1f                	jmp    16ea <printf+0x121>
    16cb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    16ce:	0f b6 00             	movzbl (%eax),%eax
    16d1:	0f be c0             	movsbl %al,%eax
    16d4:	89 44 24 04          	mov    %eax,0x4(%esp)
    16d8:	8b 45 08             	mov    0x8(%ebp),%eax
    16db:	89 04 24             	mov    %eax,(%esp)
    16de:	e8 0d fe ff ff       	call   14f0 <putc>
    16e3:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    16e7:	eb 01                	jmp    16ea <printf+0x121>
    16e9:	90                   	nop
    16ea:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    16ed:	0f b6 00             	movzbl (%eax),%eax
    16f0:	84 c0                	test   %al,%al
    16f2:	75 d7                	jne    16cb <printf+0x102>
    16f4:	eb 68                	jmp    175e <printf+0x195>
    16f6:	83 7d e8 63          	cmpl   $0x63,-0x18(%ebp)
    16fa:	75 1d                	jne    1719 <printf+0x150>
    16fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16ff:	8b 00                	mov    (%eax),%eax
    1701:	0f be c0             	movsbl %al,%eax
    1704:	89 44 24 04          	mov    %eax,0x4(%esp)
    1708:	8b 45 08             	mov    0x8(%ebp),%eax
    170b:	89 04 24             	mov    %eax,(%esp)
    170e:	e8 dd fd ff ff       	call   14f0 <putc>
    1713:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    1717:	eb 45                	jmp    175e <printf+0x195>
    1719:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    171d:	75 17                	jne    1736 <printf+0x16d>
    171f:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1722:	0f be c0             	movsbl %al,%eax
    1725:	89 44 24 04          	mov    %eax,0x4(%esp)
    1729:	8b 45 08             	mov    0x8(%ebp),%eax
    172c:	89 04 24             	mov    %eax,(%esp)
    172f:	e8 bc fd ff ff       	call   14f0 <putc>
    1734:	eb 28                	jmp    175e <printf+0x195>
    1736:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
    173d:	00 
    173e:	8b 45 08             	mov    0x8(%ebp),%eax
    1741:	89 04 24             	mov    %eax,(%esp)
    1744:	e8 a7 fd ff ff       	call   14f0 <putc>
    1749:	8b 45 e8             	mov    -0x18(%ebp),%eax
    174c:	0f be c0             	movsbl %al,%eax
    174f:	89 44 24 04          	mov    %eax,0x4(%esp)
    1753:	8b 45 08             	mov    0x8(%ebp),%eax
    1756:	89 04 24             	mov    %eax,(%esp)
    1759:	e8 92 fd ff ff       	call   14f0 <putc>
    175e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1765:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1769:	8b 55 0c             	mov    0xc(%ebp),%edx
    176c:	8b 45 ec             	mov    -0x14(%ebp),%eax
    176f:	8d 04 02             	lea    (%edx,%eax,1),%eax
    1772:	0f b6 00             	movzbl (%eax),%eax
    1775:	84 c0                	test   %al,%al
    1777:	0f 85 6e fe ff ff    	jne    15eb <printf+0x22>
    177d:	c9                   	leave  
    177e:	c3                   	ret    
    177f:	90                   	nop

00001780 <free>:
    1780:	55                   	push   %ebp
    1781:	89 e5                	mov    %esp,%ebp
    1783:	83 ec 10             	sub    $0x10,%esp
    1786:	8b 45 08             	mov    0x8(%ebp),%eax
    1789:	83 e8 08             	sub    $0x8,%eax
    178c:	89 45 f8             	mov    %eax,-0x8(%ebp)
    178f:	a1 a8 1c 00 00       	mov    0x1ca8,%eax
    1794:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1797:	eb 24                	jmp    17bd <free+0x3d>
    1799:	8b 45 fc             	mov    -0x4(%ebp),%eax
    179c:	8b 00                	mov    (%eax),%eax
    179e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    17a1:	77 12                	ja     17b5 <free+0x35>
    17a3:	8b 45 f8             	mov    -0x8(%ebp),%eax
    17a6:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    17a9:	77 24                	ja     17cf <free+0x4f>
    17ab:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17ae:	8b 00                	mov    (%eax),%eax
    17b0:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    17b3:	77 1a                	ja     17cf <free+0x4f>
    17b5:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17b8:	8b 00                	mov    (%eax),%eax
    17ba:	89 45 fc             	mov    %eax,-0x4(%ebp)
    17bd:	8b 45 f8             	mov    -0x8(%ebp),%eax
    17c0:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    17c3:	76 d4                	jbe    1799 <free+0x19>
    17c5:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17c8:	8b 00                	mov    (%eax),%eax
    17ca:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    17cd:	76 ca                	jbe    1799 <free+0x19>
    17cf:	8b 45 f8             	mov    -0x8(%ebp),%eax
    17d2:	8b 40 04             	mov    0x4(%eax),%eax
    17d5:	c1 e0 03             	shl    $0x3,%eax
    17d8:	89 c2                	mov    %eax,%edx
    17da:	03 55 f8             	add    -0x8(%ebp),%edx
    17dd:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17e0:	8b 00                	mov    (%eax),%eax
    17e2:	39 c2                	cmp    %eax,%edx
    17e4:	75 24                	jne    180a <free+0x8a>
    17e6:	8b 45 f8             	mov    -0x8(%ebp),%eax
    17e9:	8b 50 04             	mov    0x4(%eax),%edx
    17ec:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17ef:	8b 00                	mov    (%eax),%eax
    17f1:	8b 40 04             	mov    0x4(%eax),%eax
    17f4:	01 c2                	add    %eax,%edx
    17f6:	8b 45 f8             	mov    -0x8(%ebp),%eax
    17f9:	89 50 04             	mov    %edx,0x4(%eax)
    17fc:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17ff:	8b 00                	mov    (%eax),%eax
    1801:	8b 10                	mov    (%eax),%edx
    1803:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1806:	89 10                	mov    %edx,(%eax)
    1808:	eb 0a                	jmp    1814 <free+0x94>
    180a:	8b 45 fc             	mov    -0x4(%ebp),%eax
    180d:	8b 10                	mov    (%eax),%edx
    180f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1812:	89 10                	mov    %edx,(%eax)
    1814:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1817:	8b 40 04             	mov    0x4(%eax),%eax
    181a:	c1 e0 03             	shl    $0x3,%eax
    181d:	03 45 fc             	add    -0x4(%ebp),%eax
    1820:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1823:	75 20                	jne    1845 <free+0xc5>
    1825:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1828:	8b 50 04             	mov    0x4(%eax),%edx
    182b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    182e:	8b 40 04             	mov    0x4(%eax),%eax
    1831:	01 c2                	add    %eax,%edx
    1833:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1836:	89 50 04             	mov    %edx,0x4(%eax)
    1839:	8b 45 f8             	mov    -0x8(%ebp),%eax
    183c:	8b 10                	mov    (%eax),%edx
    183e:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1841:	89 10                	mov    %edx,(%eax)
    1843:	eb 08                	jmp    184d <free+0xcd>
    1845:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1848:	8b 55 f8             	mov    -0x8(%ebp),%edx
    184b:	89 10                	mov    %edx,(%eax)
    184d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1850:	a3 a8 1c 00 00       	mov    %eax,0x1ca8
    1855:	c9                   	leave  
    1856:	c3                   	ret    

00001857 <morecore>:
    1857:	55                   	push   %ebp
    1858:	89 e5                	mov    %esp,%ebp
    185a:	83 ec 28             	sub    $0x28,%esp
    185d:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    1864:	77 07                	ja     186d <morecore+0x16>
    1866:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
    186d:	8b 45 08             	mov    0x8(%ebp),%eax
    1870:	c1 e0 03             	shl    $0x3,%eax
    1873:	89 04 24             	mov    %eax,(%esp)
    1876:	e8 35 fc ff ff       	call   14b0 <sbrk>
    187b:	89 45 f0             	mov    %eax,-0x10(%ebp)
    187e:	83 7d f0 ff          	cmpl   $0xffffffff,-0x10(%ebp)
    1882:	75 07                	jne    188b <morecore+0x34>
    1884:	b8 00 00 00 00       	mov    $0x0,%eax
    1889:	eb 22                	jmp    18ad <morecore+0x56>
    188b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    188e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1891:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1894:	8b 55 08             	mov    0x8(%ebp),%edx
    1897:	89 50 04             	mov    %edx,0x4(%eax)
    189a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    189d:	83 c0 08             	add    $0x8,%eax
    18a0:	89 04 24             	mov    %eax,(%esp)
    18a3:	e8 d8 fe ff ff       	call   1780 <free>
    18a8:	a1 a8 1c 00 00       	mov    0x1ca8,%eax
    18ad:	c9                   	leave  
    18ae:	c3                   	ret    

000018af <malloc>:
    18af:	55                   	push   %ebp
    18b0:	89 e5                	mov    %esp,%ebp
    18b2:	83 ec 28             	sub    $0x28,%esp
    18b5:	8b 45 08             	mov    0x8(%ebp),%eax
    18b8:	83 c0 07             	add    $0x7,%eax
    18bb:	c1 e8 03             	shr    $0x3,%eax
    18be:	83 c0 01             	add    $0x1,%eax
    18c1:	89 45 f4             	mov    %eax,-0xc(%ebp)
    18c4:	a1 a8 1c 00 00       	mov    0x1ca8,%eax
    18c9:	89 45 f0             	mov    %eax,-0x10(%ebp)
    18cc:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    18d0:	75 23                	jne    18f5 <malloc+0x46>
    18d2:	c7 45 f0 a0 1c 00 00 	movl   $0x1ca0,-0x10(%ebp)
    18d9:	8b 45 f0             	mov    -0x10(%ebp),%eax
    18dc:	a3 a8 1c 00 00       	mov    %eax,0x1ca8
    18e1:	a1 a8 1c 00 00       	mov    0x1ca8,%eax
    18e6:	a3 a0 1c 00 00       	mov    %eax,0x1ca0
    18eb:	c7 05 a4 1c 00 00 00 	movl   $0x0,0x1ca4
    18f2:	00 00 00 
    18f5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    18f8:	8b 00                	mov    (%eax),%eax
    18fa:	89 45 ec             	mov    %eax,-0x14(%ebp)
    18fd:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1900:	8b 40 04             	mov    0x4(%eax),%eax
    1903:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1906:	72 4d                	jb     1955 <malloc+0xa6>
    1908:	8b 45 ec             	mov    -0x14(%ebp),%eax
    190b:	8b 40 04             	mov    0x4(%eax),%eax
    190e:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1911:	75 0c                	jne    191f <malloc+0x70>
    1913:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1916:	8b 10                	mov    (%eax),%edx
    1918:	8b 45 f0             	mov    -0x10(%ebp),%eax
    191b:	89 10                	mov    %edx,(%eax)
    191d:	eb 26                	jmp    1945 <malloc+0x96>
    191f:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1922:	8b 40 04             	mov    0x4(%eax),%eax
    1925:	89 c2                	mov    %eax,%edx
    1927:	2b 55 f4             	sub    -0xc(%ebp),%edx
    192a:	8b 45 ec             	mov    -0x14(%ebp),%eax
    192d:	89 50 04             	mov    %edx,0x4(%eax)
    1930:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1933:	8b 40 04             	mov    0x4(%eax),%eax
    1936:	c1 e0 03             	shl    $0x3,%eax
    1939:	01 45 ec             	add    %eax,-0x14(%ebp)
    193c:	8b 45 ec             	mov    -0x14(%ebp),%eax
    193f:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1942:	89 50 04             	mov    %edx,0x4(%eax)
    1945:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1948:	a3 a8 1c 00 00       	mov    %eax,0x1ca8
    194d:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1950:	83 c0 08             	add    $0x8,%eax
    1953:	eb 38                	jmp    198d <malloc+0xde>
    1955:	a1 a8 1c 00 00       	mov    0x1ca8,%eax
    195a:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    195d:	75 1b                	jne    197a <malloc+0xcb>
    195f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1962:	89 04 24             	mov    %eax,(%esp)
    1965:	e8 ed fe ff ff       	call   1857 <morecore>
    196a:	89 45 ec             	mov    %eax,-0x14(%ebp)
    196d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1971:	75 07                	jne    197a <malloc+0xcb>
    1973:	b8 00 00 00 00       	mov    $0x0,%eax
    1978:	eb 13                	jmp    198d <malloc+0xde>
    197a:	8b 45 ec             	mov    -0x14(%ebp),%eax
    197d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1980:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1983:	8b 00                	mov    (%eax),%eax
    1985:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1988:	e9 70 ff ff ff       	jmp    18fd <malloc+0x4e>
    198d:	c9                   	leave  
    198e:	c3                   	ret    
    198f:	90                   	nop

00001990 <xchg>:
    1990:	55                   	push   %ebp
    1991:	89 e5                	mov    %esp,%ebp
    1993:	83 ec 10             	sub    $0x10,%esp
    1996:	8b 55 08             	mov    0x8(%ebp),%edx
    1999:	8b 45 0c             	mov    0xc(%ebp),%eax
    199c:	8b 4d 08             	mov    0x8(%ebp),%ecx
    199f:	f0 87 02             	lock xchg %eax,(%edx)
    19a2:	89 45 fc             	mov    %eax,-0x4(%ebp)
    19a5:	8b 45 fc             	mov    -0x4(%ebp),%eax
    19a8:	c9                   	leave  
    19a9:	c3                   	ret    

000019aa <lock_init>:
    19aa:	55                   	push   %ebp
    19ab:	89 e5                	mov    %esp,%ebp
    19ad:	8b 45 08             	mov    0x8(%ebp),%eax
    19b0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    19b6:	5d                   	pop    %ebp
    19b7:	c3                   	ret    

000019b8 <lock_acquire>:
    19b8:	55                   	push   %ebp
    19b9:	89 e5                	mov    %esp,%ebp
    19bb:	83 ec 08             	sub    $0x8,%esp
    19be:	8b 45 08             	mov    0x8(%ebp),%eax
    19c1:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    19c8:	00 
    19c9:	89 04 24             	mov    %eax,(%esp)
    19cc:	e8 bf ff ff ff       	call   1990 <xchg>
    19d1:	85 c0                	test   %eax,%eax
    19d3:	75 e9                	jne    19be <lock_acquire+0x6>
    19d5:	c9                   	leave  
    19d6:	c3                   	ret    

000019d7 <lock_release>:
    19d7:	55                   	push   %ebp
    19d8:	89 e5                	mov    %esp,%ebp
    19da:	83 ec 08             	sub    $0x8,%esp
    19dd:	8b 45 08             	mov    0x8(%ebp),%eax
    19e0:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    19e7:	00 
    19e8:	89 04 24             	mov    %eax,(%esp)
    19eb:	e8 a0 ff ff ff       	call   1990 <xchg>
    19f0:	c9                   	leave  
    19f1:	c3                   	ret    

000019f2 <thread_create>:
    19f2:	55                   	push   %ebp
    19f3:	89 e5                	mov    %esp,%ebp
    19f5:	83 ec 28             	sub    $0x28,%esp
    19f8:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
    19ff:	e8 ab fe ff ff       	call   18af <malloc>
    1a04:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1a07:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1a0a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1a0d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1a10:	25 ff 0f 00 00       	and    $0xfff,%eax
    1a15:	85 c0                	test   %eax,%eax
    1a17:	74 15                	je     1a2e <thread_create+0x3c>
    1a19:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1a1c:	89 c2                	mov    %eax,%edx
    1a1e:	81 e2 ff 0f 00 00    	and    $0xfff,%edx
    1a24:	b8 00 10 00 00       	mov    $0x1000,%eax
    1a29:	29 d0                	sub    %edx,%eax
    1a2b:	01 45 f0             	add    %eax,-0x10(%ebp)
    1a2e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1a32:	75 1b                	jne    1a4f <thread_create+0x5d>
    1a34:	c7 44 24 04 40 1c 00 	movl   $0x1c40,0x4(%esp)
    1a3b:	00 
    1a3c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1a43:	e8 81 fb ff ff       	call   15c9 <printf>
    1a48:	b8 00 00 00 00       	mov    $0x0,%eax
    1a4d:	eb 6f                	jmp    1abe <thread_create+0xcc>
    1a4f:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    1a52:	8b 55 08             	mov    0x8(%ebp),%edx
    1a55:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1a58:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
    1a5c:	89 54 24 08          	mov    %edx,0x8(%esp)
    1a60:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
    1a67:	00 
    1a68:	89 04 24             	mov    %eax,(%esp)
    1a6b:	e8 58 fa ff ff       	call   14c8 <clone>
    1a70:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1a73:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1a77:	79 1b                	jns    1a94 <thread_create+0xa2>
    1a79:	c7 44 24 04 4e 1c 00 	movl   $0x1c4e,0x4(%esp)
    1a80:	00 
    1a81:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1a88:	e8 3c fb ff ff       	call   15c9 <printf>
    1a8d:	b8 00 00 00 00       	mov    $0x0,%eax
    1a92:	eb 2a                	jmp    1abe <thread_create+0xcc>
    1a94:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1a98:	7e 05                	jle    1a9f <thread_create+0xad>
    1a9a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a9d:	eb 1f                	jmp    1abe <thread_create+0xcc>
    1a9f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1aa3:	75 14                	jne    1ab9 <thread_create+0xc7>
    1aa5:	c7 44 24 04 5b 1c 00 	movl   $0x1c5b,0x4(%esp)
    1aac:	00 
    1aad:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1ab4:	e8 10 fb ff ff       	call   15c9 <printf>
    1ab9:	b8 00 00 00 00       	mov    $0x0,%eax
    1abe:	c9                   	leave  
    1abf:	c3                   	ret    

00001ac0 <random>:
    1ac0:	55                   	push   %ebp
    1ac1:	89 e5                	mov    %esp,%ebp
    1ac3:	a1 80 1c 00 00       	mov    0x1c80,%eax
    1ac8:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
    1ace:	05 69 f3 6e 3c       	add    $0x3c6ef369,%eax
    1ad3:	a3 80 1c 00 00       	mov    %eax,0x1c80
    1ad8:	a1 80 1c 00 00       	mov    0x1c80,%eax
    1add:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1ae0:	ba 00 00 00 00       	mov    $0x0,%edx
    1ae5:	f7 f1                	div    %ecx
    1ae7:	89 d0                	mov    %edx,%eax
    1ae9:	5d                   	pop    %ebp
    1aea:	c3                   	ret    
    1aeb:	90                   	nop

00001aec <init_q>:
    1aec:	55                   	push   %ebp
    1aed:	89 e5                	mov    %esp,%ebp
    1aef:	8b 45 08             	mov    0x8(%ebp),%eax
    1af2:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    1af8:	8b 45 08             	mov    0x8(%ebp),%eax
    1afb:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    1b02:	8b 45 08             	mov    0x8(%ebp),%eax
    1b05:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
    1b0c:	5d                   	pop    %ebp
    1b0d:	c3                   	ret    

00001b0e <add_q>:
    1b0e:	55                   	push   %ebp
    1b0f:	89 e5                	mov    %esp,%ebp
    1b11:	83 ec 28             	sub    $0x28,%esp
    1b14:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
    1b1b:	e8 8f fd ff ff       	call   18af <malloc>
    1b20:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1b23:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b26:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    1b2d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b30:	8b 55 0c             	mov    0xc(%ebp),%edx
    1b33:	89 10                	mov    %edx,(%eax)
    1b35:	8b 45 08             	mov    0x8(%ebp),%eax
    1b38:	8b 40 04             	mov    0x4(%eax),%eax
    1b3b:	85 c0                	test   %eax,%eax
    1b3d:	75 0b                	jne    1b4a <add_q+0x3c>
    1b3f:	8b 45 08             	mov    0x8(%ebp),%eax
    1b42:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1b45:	89 50 04             	mov    %edx,0x4(%eax)
    1b48:	eb 0c                	jmp    1b56 <add_q+0x48>
    1b4a:	8b 45 08             	mov    0x8(%ebp),%eax
    1b4d:	8b 40 08             	mov    0x8(%eax),%eax
    1b50:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1b53:	89 50 04             	mov    %edx,0x4(%eax)
    1b56:	8b 45 08             	mov    0x8(%ebp),%eax
    1b59:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1b5c:	89 50 08             	mov    %edx,0x8(%eax)
    1b5f:	8b 45 08             	mov    0x8(%ebp),%eax
    1b62:	8b 00                	mov    (%eax),%eax
    1b64:	8d 50 01             	lea    0x1(%eax),%edx
    1b67:	8b 45 08             	mov    0x8(%ebp),%eax
    1b6a:	89 10                	mov    %edx,(%eax)
    1b6c:	c9                   	leave  
    1b6d:	c3                   	ret    

00001b6e <empty_q>:
    1b6e:	55                   	push   %ebp
    1b6f:	89 e5                	mov    %esp,%ebp
    1b71:	8b 45 08             	mov    0x8(%ebp),%eax
    1b74:	8b 00                	mov    (%eax),%eax
    1b76:	85 c0                	test   %eax,%eax
    1b78:	75 07                	jne    1b81 <empty_q+0x13>
    1b7a:	b8 01 00 00 00       	mov    $0x1,%eax
    1b7f:	eb 05                	jmp    1b86 <empty_q+0x18>
    1b81:	b8 00 00 00 00       	mov    $0x0,%eax
    1b86:	5d                   	pop    %ebp
    1b87:	c3                   	ret    

00001b88 <pop_q>:
    1b88:	55                   	push   %ebp
    1b89:	89 e5                	mov    %esp,%ebp
    1b8b:	83 ec 28             	sub    $0x28,%esp
    1b8e:	8b 45 08             	mov    0x8(%ebp),%eax
    1b91:	89 04 24             	mov    %eax,(%esp)
    1b94:	e8 d5 ff ff ff       	call   1b6e <empty_q>
    1b99:	85 c0                	test   %eax,%eax
    1b9b:	75 5d                	jne    1bfa <pop_q+0x72>
    1b9d:	8b 45 08             	mov    0x8(%ebp),%eax
    1ba0:	8b 40 04             	mov    0x4(%eax),%eax
    1ba3:	8b 00                	mov    (%eax),%eax
    1ba5:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1ba8:	8b 45 08             	mov    0x8(%ebp),%eax
    1bab:	8b 40 04             	mov    0x4(%eax),%eax
    1bae:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1bb1:	8b 45 08             	mov    0x8(%ebp),%eax
    1bb4:	8b 40 04             	mov    0x4(%eax),%eax
    1bb7:	8b 50 04             	mov    0x4(%eax),%edx
    1bba:	8b 45 08             	mov    0x8(%ebp),%eax
    1bbd:	89 50 04             	mov    %edx,0x4(%eax)
    1bc0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1bc3:	89 04 24             	mov    %eax,(%esp)
    1bc6:	e8 b5 fb ff ff       	call   1780 <free>
    1bcb:	8b 45 08             	mov    0x8(%ebp),%eax
    1bce:	8b 00                	mov    (%eax),%eax
    1bd0:	8d 50 ff             	lea    -0x1(%eax),%edx
    1bd3:	8b 45 08             	mov    0x8(%ebp),%eax
    1bd6:	89 10                	mov    %edx,(%eax)
    1bd8:	8b 45 08             	mov    0x8(%ebp),%eax
    1bdb:	8b 00                	mov    (%eax),%eax
    1bdd:	85 c0                	test   %eax,%eax
    1bdf:	75 14                	jne    1bf5 <pop_q+0x6d>
    1be1:	8b 45 08             	mov    0x8(%ebp),%eax
    1be4:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    1beb:	8b 45 08             	mov    0x8(%ebp),%eax
    1bee:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
    1bf5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1bf8:	eb 05                	jmp    1bff <pop_q+0x77>
    1bfa:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1bff:	c9                   	leave  
    1c00:	c3                   	ret    
